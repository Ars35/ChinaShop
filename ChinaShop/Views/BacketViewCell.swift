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
    @IBOutlet weak var backetPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
