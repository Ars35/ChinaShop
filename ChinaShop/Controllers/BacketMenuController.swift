//
//  BacketMenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 20.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class BacketMenuController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var backetModel : BacketModel? = nil{
        didSet{
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard  backetModel != nil else {
            return 0
        }
        return backetModel!.items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BacketViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as! BacketViewCell
        
        cell.backetPrice.text = backetModel!.items[indexPath.row].price.description
        cell.backetName.text = backetModel!.items[indexPath.row].name
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(backetModel?.items.count)
        // Do any additional setup after loading the view.
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
