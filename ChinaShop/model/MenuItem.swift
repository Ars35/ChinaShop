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
    
    init(name : String , price: Double) {
        self.name = name
        self.price = price
    }
    
}
