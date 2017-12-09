//
//  File.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 09.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

struct MenuItemStruct : Decodable{
    //
//    {
//    "_id": "5a2249028956530014549ec4",
//    "name": "california sesame",
//    "itemId": "2pARqv",
//    "description": "california description",
//    "price": "36",
//    "imageUrl": "http://res.cloudinary.com/hqwr3xrqp/image/upload/v1512196354/xatizexwgmauhuexz8jk.png"
//    }
    //
    var _id : String
    let name : String
    var itemId : String
    var description: String
    let price : String
    var imageUrl: String?
}
struct DataStruct : Decodable{
    var items : [MenuItemStruct]
}
struct ResponceMenu : Decodable{
    var status : String
    var data : DataStruct
    
}
