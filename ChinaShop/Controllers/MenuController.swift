//
//  MenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit




class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var myMenuView: UICollectionView!
    
//    var model : MenuModel = MenuModel(items: [
//        MenuItem(name: "sushi", price: 5, url: "https://img.grouponcdn.com/deal/hfefAup1zQWBE2K8sWURgS27xax/hf-846x508/v1/c700x420.jpg"),
//        MenuItem(name: "roll", price: 12.2, url: "http://www.sam-sebe-povar.com/sites/default/files/images/sushi-plate.preview.jpg"),
//        MenuItem(name : "KARTOHA" , price : 13.5, url: "http://www.rabstol.net/uploads/gallery/comthumb/95/rabstol_net_sushi_09.jpg")
//    ])
    var menuItemsArray = [MenuItem]()
    
    var backetModel = BacketModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMenuView.delegate = self
        myMenuView.dataSource = self
        
        //test purpose
        DownloadService.instance.delegate = self
        
        menuItemsArray = MainService.instance.getItems()
        
        

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item : MenuItem = menuItemsArray[indexPath.item]
        //dobavit v service
        MainService.instance.addToBacket(forName: item.name)
        
        print("Added to backet \(item.name)")
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "basketSegue"{
//            for item in menuItemsArray {
//                if item.count > 0{
//                    backetModel.items.append(item)
//                }
//            }
//            if let backetController :BacketMenuController = segue.destination as? BacketMenuController  {
//                backetController.backetModel = self.backetModel 
//            }
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return menuItemsArray.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuItemCell" , for: indexPath) as! MenuCell
    
        // Configure the cell
        let menuItem = menuItemsArray[indexPath.item]
        
        cell.cellInit(item: menuItem)
        
        
        return cell
    }
}

extension MenuController: DownloadServiceDelegate {
    func downloadCompleated(responce: DownloadResponce) {
        print("This is Message from delegate.")
        if responce.errorString != nil {
            print("Error: \(responce.errorString!)")
        } else {
            print("responce: \(responce.urlPatch!)")
        }
        
        DispatchQueue.main.async {
            self.myMenuView.reloadData()
        }
    }
    
    
}
