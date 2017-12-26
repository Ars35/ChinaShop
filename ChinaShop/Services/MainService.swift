//
//  MainService.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 03.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

class MainService {
    
    static let instance = MainService()
    
    var itemList = [MenuItem]()
    var lastItem: MenuItem?
    
    
    func getItems(completion: @escaping (String) -> ())  {
        let urlString : String = "https://sushiserver.herokuapp.com/items"
        let url = URL(string : urlString)
        URLSession.shared.dataTask(with: url!){
            (data , responce , error)
            in
            guard let data = data else {
                completion("ERROR IN DATA")
                return
            }
            var json : ResponceMenu?
            var errorMessage: String = ""
            
            do {
                json = try JSONDecoder().decode(ResponceMenu.self, from: data)
                
            } catch let parseError as NSError {
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                print(errorMessage)
                return
            }
//            print(json)
            for item in (json?.data.items)! {
                
                var priceDouble: Double = 0.0
                if Double(item.price) == nil {
                    var tempString = item.price
                    let otherRange = tempString.index(of: " ")!..<tempString.endIndex
                    tempString.removeSubrange(otherRange)
                    print(tempString)
                    priceDouble = Double(tempString)!
                    
                } else {
                    priceDouble = Double(item.price)!
                }
                let tempMenuItem = MenuItem(id: item._id, name: item.name, itemId: item.itemId, description: item.description, price: priceDouble, url: item.imageUrl!)
                self.itemList.append(tempMenuItem)
            }
            completion("PARSING OK")
        }.resume()
    
    }
    
    func addToBacket(forName itemName: String) {
        for item in itemList {
            if item.name == itemName {
                self.lastItem = item
                item.count += 1
            }
        }
    }
    
    func clearDataAfterSendAndReturnToTheMainController(){
        for item in self.getBacket(){
            item.count = 0
        }
        
        
    }
    
    func getBacket() -> [MenuItem] {
        var backetArray = [MenuItem]()
        for item in itemList {
            if item.count > 0 {
                backetArray.append(item)
            }
        }
        return backetArray
    }
    
    func removeLast() {
        self.lastItem?.count -= 1
    }
    
    func prepareForJson() -> [ItemOrder] {
        var tempArr = [ItemOrder]()
        if self.getBacket().count > 0 {
            for item in self.getBacket() {
                let orderItem = ItemOrder(id: item.itemId, amount: item.count)
                tempArr.append(orderItem)
            }
        }
        
        return tempArr
    }
    
    func sendOrder(name: String, adress: String, phone: String ,completion: @escaping (String) -> ())  {
        let data = self.prepareForJson()

        let order = Order(order: data, name: name, address: adress, phone: phone)
        
        let urlString : String = "https://sushiserver.herokuapp.com/orders"
        
        
        guard let url = URL(string : urlString) else {return}
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        var json : Data
        var errorMessage: String = ""
        print("order: \(order)")
        
        do{
            try json  =  JSONEncoder().encode(order)
            
        }
        catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            print(errorMessage)
            return
        }

        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) {
            (data , responce , error)
            in
            guard let data = data else {
                completion("ERROR IN DATA")
                return
            }
            var json : ResponceOrder?
            var errorMessage: String = ""
            
            do {
                json = try JSONDecoder().decode(ResponceOrder.self, from: data)
                
            } catch let parseError as NSError {
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                print(errorMessage)
                print(data.base64EncodedString())
                
                
                return
            }
            print(json)
            
            
            completion("PARSING OK")
            }.resume()
        
    }
}
