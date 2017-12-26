//
//  MenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit




class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        closeNotification()
    }
    
    @IBAction func toCartBtnPressed(_ sender: Any) {
        closeNotification()
        if MainService.instance.getBacket().count > 0 {
            performSegue(withIdentifier: TO_BASKET_SEGUAE, sender: nil)
        }
        
    }
    
    @IBAction func undoBtnPressed(_ sender: Any) {
        MainService.instance.removeLast()
        closeNotification()
    }
    
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var basketBtn: UIBarButtonItem!
    @IBOutlet weak var spesialImage: UIImageView!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var myMenuView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var menuItemsArray = [MenuItem]()
    
    var backetModel = BacketModel()
   
    
    @objc func addToCartResponder(_ notif: Notification) {
        self.showNotification()
        if MainService.instance.getBacket().count > 0 {
            basketBtn.image = UIImage(named: "check")// полная
        } else {
            basketBtn.image = UIImage(named: "check")// пустая

        }
    }
    
    private func closeNotification() {
        notificationView.isHidden = true
    }
    private func showNotification() {
        notificationView.isHidden = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
//            self.closeNotification()
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuController.addToCartResponder(_:)), name: NOTIF_ADD_TO_CART, object: nil)
        
        myMenuView.delegate = self
        myMenuView.dataSource = self
        spinner.isHidden = false
        spinner.startAnimating()
        notificationView.isHidden = true
        
        //test purpose
        DownloadService.instance.delegate = self
       
        //barbutton start
        let donVTemp = UILabel()
        donVTemp.sizeToFit()
        donVTemp.text = "Anna Sushi"
        donVTemp.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        let leftButton = UIBarButtonItem(customView: donVTemp)
        self.navigationItem.leftBarButtonItem = leftButton
        //barbutton end
        
       //загрузка меню
        MainService.instance.getItems { (error) in
            if error == "PARSING OK" {
                self.menuItemsArray = MainService.instance.itemList
                self.getSpecialList()
                
                DispatchQueue.main.async {
                    self.myMenuView.reloadData()
                    
                }
            }else {
                print(error)
            }
            
        }
    }
    
    private func getSpecialList() {
        //загрузка спешиалс
        SpecialService.instance.getSpecialList { (error) in
            if error == "PARSING OK" {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
                
                let specialUrlImage = SpecialService.instance.spesialList[0].imageUrl
                
                self.load_image(urlString: specialUrlImage!)
                print("SPECIAL URL STRING: \(specialUrlImage)")
            }else {
                print(error)
            }
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item : MenuItem = menuItemsArray[indexPath.item]
        //dobavit v service
        //MainService.instance.addToBacket(forName: item.name)
        
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
    
    
    func load_image(urlString:String)
    {
        
        let imgURL: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse!,data: Data!,error: Error!) -> Void in
                if error == nil {
                    self.spesialImage.image = UIImage(data: data)
                }
        })
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
