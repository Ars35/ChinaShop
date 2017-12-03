//
//  BacketViewCell.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 24.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class BacketViewCell: UITableViewCell {

    
    @IBOutlet weak var backetName: UILabel!
    @IBOutlet weak var backetPrice: PriceLable!
    
    @IBOutlet weak var backetImage: UIImageView!
    @IBOutlet weak var itemsCounLbl: UILabel!
    
    func cellInit(item: MenuItem) {
        
        backetName.text = item.name
        backetPrice.setText(price: item.price)
        itemsCounLbl.text = String(item.count)
        
        let image = UIImage(contentsOfFile: item.localFilePath!)
        backetImage.image = image
    }

}
