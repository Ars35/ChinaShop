//
//  OrderController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class OrderController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textAdress: UITextField!
    
    @IBOutlet weak var textPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
       
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
