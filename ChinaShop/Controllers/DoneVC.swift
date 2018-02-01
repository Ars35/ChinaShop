//
//  DoneVC.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 25.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class DoneVC: UIViewController {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var doneImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    

    
    func setupView() {
        //-50
        doneImage.backgroundColor = UIColor.purple
        doneImage.layer.cornerRadius = 0.5 * doneImage.bounds.size.width
        doneImage.clipsToBounds = true
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(DoneVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NOTIF_ORDER_DONE, object: nil)
    }

}
