//
//  BacketMenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 20.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 27, weight: UIFont.Weight.bold)]
        
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

class BacketMenuController: UIViewController , UITableViewDelegate, UITableViewDataSource, BasketDelegate {
    
    
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLbl: UILabel!
    
    var orderItemsArray = [MenuItem]()
    var spesialList = [SpecialItemStruct]()
    var odrers = [ItemOrder]()
    func buttonsParametrs() {
    
        orderButton.layer.cornerRadius = 10
        orderButton.clipsToBounds = true
        orderButton.backgroundColor = #colorLiteral(red: 0.7931956053, green: 0.115777202, blue: 0.2298518419, alpha: 1)
        
    
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
    MainService.instance.clearDataAfterSendAndReturnToTheMainController()
        NotificationCenter.default.post(name: NOTIF_ADD_TO_CART, object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderItemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BacketViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as! BacketViewCell
        
        cell.cellInit(item: orderItemsArray[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func cellViewUpdate(cellId: MenuItem) {
        DispatchQueue.main.async {
            self.orderItemsArray = MainService.instance.getBacket()
            self.tableView.reloadData()
            self.totalLbl.attributedText = self.calculateTotalToString()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderItemsArray = MainService.instance.getBacket()
        print(orderItemsArray.count)
        // Do any additional setup after loading the view.
        totalLbl.attributedText = calculateTotalToString()
       buttonsParametrs()
        
    }

    
    func calculateTotalToString() -> NSMutableAttributedString {
        var total = 0.0
        for item in orderItemsArray {
            total += Double(item.count) * item.price
        }
        
        let formattedString = NSMutableAttributedString()
        formattedString
            .bold("\(Int(total))")
            .normal(" RMB")
        
        return formattedString
    }
    
    @IBAction func orderBtnPressed(_ sender: Any) {
        print(MainService.instance.prepareForJson())
        if MainService.instance.prepareForJson().count > 0 {
            
            
            
            performSegue(withIdentifier: TO_ORDER_SEGUAE, sender: nil)
        }
        
        
    }

    
}
