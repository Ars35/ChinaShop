//
//  BacketViewCell.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 24.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

protocol BasketDelegate {
    func cellViewUpdate(cellId: MenuItem)
}

class BacketViewCell: UITableViewCell {

    

    @IBOutlet weak var backetName: UILabel!
    @IBOutlet weak var backetPrice: PriceLable!
    @IBOutlet weak var backetImage: UIImageView!
    @IBOutlet weak var itemsCounLbl: UILabel!
    
    var menuItem: MenuItem?
    var delegate: BasketDelegate?
    
    @IBAction func countButtonPressed(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "-":
            print("Minus BTn Pressed")
            if menuItem!.count > 1 {
                menuItem!.count -= 1
            } else {
                menuItem!.count = 0
            }
            delegate?.cellViewUpdate(cellId: menuItem!)
        case "+":
            print("Plus Btn Pressed")
            menuItem!.count += 1
            delegate?.cellViewUpdate(cellId: menuItem!)
            
        default:
            print("Default switch statment")
        }
        NotificationCenter.default.post(name: NOTIF_ADD_TO_CART, object: nil)
    }
    
    func cellInit(item: MenuItem) {
        self.menuItem = item
        
        backetName.text = item.name
        backetPrice.setText(price: item.price)
        itemsCounLbl.text = String(item.count)
        
        let image = UIImage(contentsOfFile: item.localFilePath!)
        backetImage.image = image
    }

}
