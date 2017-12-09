//
//  File.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 09.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

struct MenuItemStruct : Decodable{
    var id : String = ""
    let name : String  = ""
    var itemId : String  = ""
    var description: String  = ""
    let price : String  = ""
    var count : Int = 0
    var url: String?
    var localFilePath: String?
    var isDownloading: Bool = false
}
struct DataStruct : Decodable{
    var items : [MenuItemStruct]
}
struct ResponceMenu : Decodable{
    var status : String = ""
    var data : DataStruct
    
}
