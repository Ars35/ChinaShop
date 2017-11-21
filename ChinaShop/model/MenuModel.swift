//
//  MenuModel.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class MenuModel: NSObject {
   let items : [MenuItem]

    init(items: [MenuItem]){
        self.items = items
    }
}
