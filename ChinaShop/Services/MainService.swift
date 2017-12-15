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
                item.count += 1
            }
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
    
    func prepareForJson() -> [ItemOrder] {
        var tempArr = [ItemOrder]()
        if self.getBacket().count > 0 {
            for item in self.getBacket() {
                let orderItem = ItemOrder(id: item.id, amount: item.count)
                tempArr.append(orderItem)
            }
        }
        
        return tempArr
    }
    
    func sendOrder(completion: @escaping (String) -> ())  {
        var data = self.prepareForJson()
        var order = Order(orders: data, name: "ALEX",adress: "ADRESSSS" ,phone: "77852662554" )
        let urlString : String = "https://sushiserver.herokuapp.com/orders"
        
        
        guard let url = URL(string : urlString) else {return}
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        var json : Order
        var errorMessage: String = ""
        do{
            try json  =  JSONEncoder().encode(order)
            
        }
        catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            print(errorMessage)
            return
        }
        
        URLSession.shared.dataTask(with: url) {
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
}
