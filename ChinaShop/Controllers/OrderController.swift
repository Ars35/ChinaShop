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
    @IBOutlet weak var finalImage: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textAdress: UITextField!
    
    @IBOutlet weak var textPhone: UITextField!
    
    func buttonsParametrs() {
        
        orderButton.layer.cornerRadius = 10
        orderButton.clipsToBounds = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        finalImage.alpha = 0.0
         
        finalImage.layer.cornerRadius = finalImage.layer.frame.width / 2
        finalImage.layer.masksToBounds = true
        textName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textAdress.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textPhone.attributedPlaceholder = NSAttributedString(string: "Street, Number, Appartment", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
            buttonsParametrs()
        // Do any additional setup after loading the view.
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
               
                //тут нужно сделать обнуление данных в карзине те установить у всех итемов количество в 0
                //и перейти в начало
                DispatchQueue.main.async {
                    self.finalImage.alpha = 0.0
                    UIView.animate(withDuration: 2, animations: {
                        
                        self.finalImage.alpha = 1.0
                    }, completion: { (finished) in
                        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            DispatchQueue.main.async {
                                MainService.instance.clearDataAfterSendAndReturnToTheMainController()
                                self.navigationController?.popToRootViewController(animated: true)
                                
                            }
                        }
                    })
                    
                }
                
            } else {
                print("vse ploho")
                //тут нужно вывести сообщение о том, что что то не так
            }
        }
    }
    
}
