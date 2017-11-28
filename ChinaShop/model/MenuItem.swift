//
//  MenuItem.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    let name : String
    let price : Double
    var count : Int = 0
    var url: String?
    var localFilePath: String?
    var isDownloading: Bool = false
    
    init(name : String , price: Double, url: String) {
        self.name = name
        self.price = price
        self.url = url
    }
    
}
