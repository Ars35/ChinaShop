//
//  KartItem.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 12.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import Foundation
import UIKit

struct KartItem {
    
    static func getItem(count: Int) -> UIButton {
        var countString = ""
        var imageString = ""
        var showLbl = true
        switch count {
        case 0:
            countString = "0"
            imageString = "add shopping cart-new.png"
            showLbl = false
        case 1...9:
            countString = "\(count)"
            imageString = "cort-new.png"
        default:
            countString = "9+"
            imageString = "cort-new.png"
        }
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: imageString), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let lable = UILabel()
        
        lable.textAlignment = .center
        lable.center = btn1.center
        lable.frame.origin.x = btn1.frame.minX + 5
        lable.frame.origin.y = btn1.center.y - 5
        lable.bounds.size.height = btn1.bounds.height - 5
        lable.bounds.size.width = btn1.bounds.width - 5
        lable.clipsToBounds = true
        lable.layer.cornerRadius = lable.bounds.height / 2
        lable.backgroundColor = UIColor.red
        lable.text = countString
        lable.textColor = UIColor.white
        if showLbl {
            btn1.addSubview(lable)
        }
        
        
        return btn1
    }
}
