//
//  MenuItem.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class MenuItem: NSObject ,Codable{
    var id : String
    let name : String
    var itemId : String
   // var description: String
    let price : Double
    var count : Int = 0
    var url: String?
    var localFilePath: String?
    var isDownloading: Bool = false
    
    init(id : String ,name : String ,itemId : String ,description : String , price: Double, url: String) {
        self.id = id
        self.name = name
        self.itemId = itemId
      //  self.description = description
        self.price = price
        self.url = url
    }
    
}
