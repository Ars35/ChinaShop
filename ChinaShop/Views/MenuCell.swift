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
    
    @IBAction func cellBtnPressed(_ sender: Any) {
        print("TestBtnPresed")
        self.dim()
    }
    
    func dim() {
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0.75
        }) { (finished) in
            UIView.animate(withDuration: 0.15, animations: {
                self.alpha = 1.0
            })
        }
    }
    
    func cellInit(item: MenuItem) {
        nameLabel.text = item.name
        priceLabel.setText(price: item.price)
        
        if item.localFilePath != nil {
            
            let image = UIImage(contentsOfFile: item.localFilePath!)
            backgroundImage.image = image
        } else {
            if item.isDownloading == false {
                backgroundImage.image = UIImage(named: "default_image")
                
                DownloadService.instance.downloadPic(forMenuItem: item)
            }
        }
    }
}
