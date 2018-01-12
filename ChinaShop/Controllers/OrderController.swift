//
//  OrderController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class OrderController: UIViewController, UITextFieldDelegate {

    @IBOutlet var errorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var textName: ValidatedTextField!
    @IBOutlet weak var textAdress: ValidatedTextField!
    @IBOutlet weak var textPhone: ValidatedTextField!
    
    func buttonsParametrs() {
        
        orderButton.layer.cornerRadius = 10
        orderButton.clipsToBounds = true
        orderButton.backgroundColor = #colorLiteral(red: 0.737254902, green: 0, blue: 0.1764705882, alpha: 1)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            let item = textField as! ValidatedTextField
            if item.validateForName() {
                view.viewWithTag(2)?.becomeFirstResponder()
            }

        case 2:
            let item = textField as! ValidatedTextField
            if item.validateForTelephone() {
                view.viewWithTag(3)?.becomeFirstResponder()
            }
            
        case 3:
            let item = textField as! ValidatedTextField
            if item.validateForName() {
                textField.resignFirstResponder()
            }
            

        default:
            textField.resignFirstResponder()
        }
        //textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tags
        textName.tag = 1
        textPhone.tag = 2
        textAdress.tag = 3
        
        
        let keyboardClosetap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(keyboardClosetap)
        
        textName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textPhone.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
        textAdress.attributedPlaceholder = NSAttributedString(string: "Street,  Number,  Appartment", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ])
            buttonsParametrs()

        NotificationCenter.default.addObserver(self, selector: #selector(OrderController.userOrderDone(_:)), name: NOTIF_ORDER_DONE, object: nil)
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    //
    @objc func dismissKeyboard() {

    self.view.endEditing(true)
}
    //
    
    @objc func userOrderDone(_ notif: Notification) {
        MainService.instance.clearDataAfterSendAndReturnToTheMainController()
        self.navigationController?.popToRootViewController(animated: true)
    }

    func validateFields() -> Bool {
        let nameValid = textName.validateForName()
        let phoneValid = textPhone.validateForTelephone()
        let adressValid = textAdress.validateForName()
        if nameValid && phoneValid && adressValid {
            return true
        } else {
            return false
        }
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
        
        if self.validateFields() {
            //
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
            //
        }
        
       
    }
}

extension OrderController {
    
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
}

extension UITextField {
    
    private func generateErrorLable(_ view: UITextField) -> UILabel {
        
        let lable = UILabel()
        lable.backgroundColor = UIColor.red
        lable.clipsToBounds = true
        lable.text = "!"
        lable.textAlignment = .center
        lable.center = view.center
        lable.frame.origin.x = view.bounds.maxX - view.bounds.height * 2
        lable.bounds.size.height = view.bounds.height
        lable.bounds.size.width = view.bounds.height
        lable.layer.cornerRadius = view.bounds.height / 2
        return lable
    }
    
//
//    func validateForAdress() -> Bool {
//
//    }
}
