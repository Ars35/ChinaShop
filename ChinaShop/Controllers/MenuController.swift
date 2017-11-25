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
        
    var backetModel = BacketModel()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMenuView.delegate = self
        myMenuView.dataSource = self

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item : MenuItem = model.items[indexPath.item]
        item.count += 1
        print(item.count)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basketSegue"{
            for item in model.items {
                if item.count > 0{
                    backetModel.items.append(item)
                }
            }
            if let backetController :BacketMenuController = segue.destination as? BacketMenuController  {
                backetController.backetModel = self.backetModel 
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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


}
