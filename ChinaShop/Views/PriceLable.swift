//
//  PriceLable.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 28.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class PriceLable: UILabel {
    
    let currency = "RMB"
    
    func setText(price: Double) {
        self.text = " \(price) \(currency)  "
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }

}
