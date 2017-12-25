//
//  OrderController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class OrderController: UIViewController {

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textAdress: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    
    func buttonsParametrs() {
        
        orderButton.layer.cornerRadius = 10
        orderButton.clipsToBounds = true
        orderButton.backgroundColor = #colorLiteral(red: 0.737254902, green: 0, blue: 0.1764705882, alpha: 1)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textAdress.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textPhone.attributedPlaceholder = NSAttributedString(string: "Street, Number, Appartment", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
            buttonsParametrs()

        NotificationCenter.default.addObserver(self, selector: #selector(OrderController.userOrderDone(_:)), name: NOTIF_ORDER_DONE, object: nil)
    }
    
    @objc func userOrderDone(_ notif: Notification) {
        MainService.instance.clearDataAfterSendAndReturnToTheMainController()
        self.navigationController?.popToRootViewController(animated: true)
    }

  
    @IBAction func SendOrder(_ sender: Any) {
        guard let name : String = textName.text! else {
            return
        }
        guard let adress : String = textAdress.text! else {
            return
        }
        guard let phone : String = textPhone.text! else {
            return
        }
       
        MainService.instance.sendOrder(name: name, adress: adress, phone: phone) { (result) in
            
            if result == "PARSING OK" {
                print("vse horosho")
                DispatchQueue.main.async {
                    let doneVC = DoneVC()
                    doneVC.modalPresentationStyle = .custom
                    self.present(doneVC, animated: true, completion: nil)
                }
                
            } else {
                print("vse ploho")
                //тут нужно вывести сообщение о том, что что то не так
            }
        }
    }
    
}
