//
//  MenuControllerExtenshion.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 26.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import Foundation

extension MenuController {
    
    
    func hideAndMove() {
        self.spesialImage.frame.origin.y = self.spesialImage.frame.origin.y - self.spesialImage.frame.height
    }
    
    func scrollDirrection() {
        
        if currentScrollOffset < lastScrollOffset {
            print("Scroll Up")
            scrollGoDown = false
        } else {
            print("Scroll Down")
            scrollGoDown = true
        }
    }
    
    
}
