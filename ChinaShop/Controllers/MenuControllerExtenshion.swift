//
//  MenuControllerExtenshion.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 26.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import Foundation
import UIKit
extension MenuController {
    
    func changePosition() {
        let speshiialHeight = self.spesialImage.frame.height
        
        isSpeshialHidded = !isSpeshialHidded
        constr.constant = isSpeshialHidded ? -speshiialHeight : 8

        UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
        }
    }
    
    
    
    func scrollDirrection(){
        
        if currentScrollOffset < lastScrollOffset {
//            print("Scroll Up")
            scrollGoDown = false
        } else {
//            print("Scroll Down")
            scrollGoDown = true
        }
    }
    
    
}
