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
    
   // var itemList = instance.getItems()
    
    
    func getItems()  {
        let urlString : String = "https://sushiserver.herokuapp.com/items"
        let url = URL(string : urlString)
        URLSession.shared.dataTask(with: url!){
            [unowned self]
            (data , responce , error)
            in
            guard let data = data,
            let json = try? JSONDecoder().decode(ResponceMenu.self, from: data)
                else{
                    return
            }
                var itemList = json.data
            }
        
        return itemList
        }
        //self.itemList = [
          //  MenuItem(name: "Sushi", price: 5, url: "https:////img.grouponcdn.com/deal/hfefAup1zQWBE2K8sWURgS27xax/hf-846x508/v1/c700x420.jpg"),
          //  MenuItem(name: "Roll", price: 12.2, url: "http://www.sam-sebe-povar.com/sites/default/files/images/sushi-plate.preview.jpg"),
           //MenuItem(name : "KARTOHA" , price : 13.5, url: "http://www.rabstol.net/uploads/gallery/comthumb/95/rabstol_net_sushi_09.jpg")
        //]
        //return self.itemList
    
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

