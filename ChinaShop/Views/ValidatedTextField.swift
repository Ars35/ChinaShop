//
//  ValidatedTextField.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 11.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import UIKit

class ValidatedTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    var errorLbl: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let lable = UILabel()
        lable.backgroundColor = UIColor.red
        lable.clipsToBounds = true
        lable.text = "!"
        lable.textAlignment = .center
        lable.frame.origin.y = self.bounds.maxY / 2
        lable.bounds.size.height = self.bounds.height
        lable.bounds.size.width = self.bounds.height
        lable.layer.cornerRadius = self.bounds.height / 2
        lable.frame.origin.x = self.bounds.maxX - lable.bounds.size.width - 5 // тут отступ
        errorLbl = lable
    
        print(self.subviews.count)
        self.addSubview(errorLbl!)
        print(self.subviews.count)
        self.errorLbl!.isHidden = true
    }
    
    func showError() {
        self.errorLbl!.isHidden = false
    }
    
    func hideError() {
        self.errorLbl!.isHidden = true
    }
    
    func validateForName() -> Bool {
        if self.text == "" || self.text == " " || self.text == "   " {
            self.showError()
            return false
        } else {
            self.hideError()
            return true
        }

    }

    func validateForTelephone() -> Bool {
        if let telephone = Int(self.text!) {
            print("validated")
            self.hideError()
            return true
        } else {
            self.showError()
            return false
            
        }
    }
}
