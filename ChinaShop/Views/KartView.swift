//
//  KartView.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 12.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import UIKit

class KartView: UIButton {
    
    var lbl: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lable = UILabel()
        
        lable.textAlignment = .center
        lable.center = self.center
        lable.frame.origin.x = self.frame.minX
        lable.frame.origin.y = self.center.y - 5
        lable.bounds.size.height = self.bounds.height
        lable.bounds.size.width = self.bounds.width
        lable.clipsToBounds = true
        lable.layer.cornerRadius = lable.bounds.height / 2
        lable.backgroundColor = UIColor.red
        lable.text = "9+"
        lable.textColor = UIColor.white
        
        
        
        
        
        lbl = lable
        self.addSubview(lbl!)
    }
    
//    override init(image: UIImage?) {
//        super.init(image: image)
//        
//        let lable = UILabel()
//        lable.textAlignment = .center
//        lable.center = self.center
//        lable.frame.origin.x = self.frame.minX
//        lable.frame.origin.y = self.center.y - 5
//        lable.bounds.size.height = self.bounds.height
//        lable.bounds.size.width = self.bounds.width
//        lable.clipsToBounds = true
//        lable.layer.cornerRadius = lable.bounds.height / 2
//        lable.backgroundColor = UIColor.red
//        lable.text = "9+"
//        lable.textColor = UIColor.white
//        
//        
//        lbl = lable
//        
//        self.addSubview(lbl!)
//        
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
