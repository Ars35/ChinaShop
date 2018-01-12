//
//  LaunchViewController.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 07.01.2018.
//  Copyright © 2018 Arseniy Arseniev. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var lounchScreen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingScreen()
//startSeq
        // Do any additional setup after loading the view.
    }

    func showLoadingScreen() {

        lounchScreen.alpha  = 1
        
        //Настройки времени анимации
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
            self.lounchScreen.alpha = 0
        }) { (success) in
            self.lounchScreen.isHidden = true
            self.performSegue(withIdentifier: "startSeq", sender: nil)
        }
    }

}
