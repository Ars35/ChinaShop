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
    @IBAction func logoutPressed(_ sender: Any) {
        //UserDataServices.instance.logoutUser()
        //NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGED, object: nil)
        //dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        doneImage.clipsToBounds = true
        doneImage.layer.cornerRadius = doneImage.frame.height / 2
       
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(DoneVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NOTIF_ORDER_DONE, object: nil)
    }

}
