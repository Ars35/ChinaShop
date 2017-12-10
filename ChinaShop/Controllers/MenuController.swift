//
//  MenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit




class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var myMenuView: UICollectionView!
    
    var menuItemsArray = [MenuItem]()
    
    var backetModel = BacketModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMenuView.delegate = self
        myMenuView.dataSource = self
        
        //test purpose
        DownloadService.instance.delegate = self
        
       //загрузка меню
        MainService.instance.getItems { (error) in
            if error == "PARSING OK" {
                self.menuItemsArray = MainService.instance.itemList
                DispatchQueue.main.async {
                    self.myMenuView.reloadData()
                }
            }else {
                print(error)
            }
        }
        //загрузка спешиалс
        SpecialService.instance.getSpecialList { (error) in
            if error == "PARSING OK" {
                let specialUrlImage = SpecialService.instance.spesialList[0].imageUrl
                print("SPECIAL URL STRING: \(specialUrlImage)")
            }else {
                print(error)
            }
        }
        
        

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item : MenuItem = menuItemsArray[indexPath.item]
        //dobavit v service
        MainService.instance.addToBacket(forName: item.name)
        
        print("Added to backet \(item.name)")
        
    }

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
    
    
    //Авторасчет ширины ячейки
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 2
        
        let spaceBetweenCells: CGFloat = 15
        let cellDemension = (collectionView.bounds.width - spaceBetweenCells) / numberOfColumns
        return CGSize(width: cellDemension, height: cellDemension)

    }
}

extension MenuController: DownloadServiceDelegate {
    func downloadCompleated(responce: DownloadResponce) {
//        print("This is Message from delegate.")
        if responce.errorString != nil {
            print("Error: \(responce.errorString!)")
        } else {
            
//            print("responce: \(responce.urlPatch!)")
        }
        
        DispatchQueue.main.async {
            self.myMenuView.reloadData()
        }
    }
    
    
}
