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
}
