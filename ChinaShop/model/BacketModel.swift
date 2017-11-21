//
//  BacketModel.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 20.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class BacketModel: NSObject {
    var items = [MenuItem]()
    
    
    func getCount() -> Int {
       return items.count
    }
    
    
    
}
