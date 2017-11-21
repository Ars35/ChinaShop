//
//  MenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit




class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var myMenuView: UICollectionView!
    
    var model : MenuModel = MenuModel(items: [
        MenuItem(name: "sushi", price: 5),
        MenuItem(name: "roll", price: 12.2),
        MenuItem(name : "KARTOHA" , price : 13.5)
    ]) 
        
    var backetModel : BacketModel = BacketModel()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMenuView.delegate = self
        myMenuView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "menuItemCell" )

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item : MenuItem = model.items[indexPath.item]
        item.count += 1
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMenuToBacket"{
        for item in model.items {
            if item.count > 0{
                backetModel.items.append(item)
            }
            }
            if let backetController :BacketMenuController = segue.destination as? BacketMenuController  {
                self.backetModel = backetController.backetModel!
        }
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model.items.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuItemCell" , for: indexPath) as! MenuCell
    
        // Configure the cell
       cell.nameLabel.text = model.items[indexPath.item].name
        cell.priceLabel.text = model.items[indexPath.item].price.description
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
