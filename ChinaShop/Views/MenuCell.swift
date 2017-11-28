//
//  MenuCell.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLable!
    
    func cellInit(item: MenuItem) {
        nameLabel.text = item.name
        //priceLabel.text = String(item.price)
        priceLabel.setText(price: item.price)
        
//        priceLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        priceLabel.layer.borderWidth = 1.0
//        priceLabel.layer.cornerRadius = 5.0
        
//        priceLabel.clipsToBounds = true
        
        if item.localFilePath != nil {
            
            let image = UIImage(contentsOfFile: item.localFilePath!)
            backgroundImage.image = image
        } else {
            if item.isDownloading == false {
                backgroundImage.image = UIImage(named: "mainItem")
                
                DownloadService.instance.downloadPic(forMenuItem: item)
            }
        }
    }
}
