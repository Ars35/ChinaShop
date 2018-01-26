//
//  MenuController.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Varaibles
    var scrollGoDown = false
    var currentScrollOffset : CGFloat = 0
    var lastScrollOffset : CGFloat = 0
    
    var menuItemsArray = [MenuItem]()
    var backetModel = BacketModel()
    var testVar: CGFloat?
    
    //Outlets
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var basketBtn: UIBarButtonItem!
    @IBOutlet weak var spesialImage: UIImageView!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var myMenuView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Actions
    @IBAction func testbtnPressed(_ sender: Any) {
        self.hideAndMove()
    }
    
    @IBAction func toCartBtnPressed(_ sender: Any) {
        closeNotification()
        if MainService.instance.getBacket().count > 0 {
            performSegue(withIdentifier: TO_BASKET_SEGUAE, sender: nil)
        }
        
    }
    
    @IBAction func undoBtnPressed(_ sender: Any) {
        MainService.instance.removeLast()
        NotificationCenter.default.post(name: NOTIF_ADD_TO_CART, object: nil)
        closeNotification()
    }
    //Responders
    @objc func toCart(_ sender: Any) {
        closeNotification()
        if MainService.instance.getBacket().count > 0 {
            performSegue(withIdentifier: TO_BASKET_SEGUAE, sender: nil)
        }
        
    }
    
    @objc func addToCartResponder(_ notif: Notification) {
        let btn = KartItem.getItem(count: MainService.instance.getBacketTotal())
        btn.addTarget(self, action: #selector(self.toCart), for: .touchUpInside)
        
        let rightButton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = rightButton
        showNotification()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        currentScrollOffset = currentOffset
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        print("testVarIs: \(self.spesialImage.frame.origin.y)")
        print("Maximum: \(maximumOffset), Current: \(currentOffset), Delta: \(deltaOffset)")
//        scrollDirrection()
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        closeNotification()
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
   
//        //anna sushi lable on left
        let leftLbl = UILabel()
        leftLbl.sizeToFit()
        leftLbl.text = "Anna Sushi"
        leftLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let leftButton = UIBarButtonItem(customView: leftLbl)
        self.navigationItem.leftBarButtonItem = leftButton
//        //anna sushi lbl end

        let btn = KartItem.getItem(count: 0)
        let rightButton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = rightButton
        //barbuttons end
        self.getMenuItems()
        
        self.testVar =  self.spesialImage.frame.origin.y
       
    }
    
    
    private func getMenuItems() {
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
                let alertController = UIAlertController(title: "Communication Error", message: "\(error) \n Try Again?", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    self.getMenuItems()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
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
//                print("SPECIAL URL STRING: \(specialUrlImage)")
            }else {
                print(error)
                let alert = UIAlertController(title: "Communication Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
                    debugPrint("Special Image Set!")
                }
        })
    }
    
    //Notifications
    private func closeNotification() {
        notificationView.isHidden = true
    }
    private func showNotification() {
        notificationView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.closeNotification()
        })
    }
}

extension MenuController: DownloadServiceDelegate {
    func downloadCompleated(id : String, responce: DownloadResponce) {
//        print("This is Message from delegate.")
        if responce.errorString != nil {
            print("Error: \(responce.errorString!)")
        } else {
            var i = 0
            for item in MainService.instance.itemList {
                
                if item.id == id {
                    break
                }
                i += 1
            }
            DispatchQueue.main.async {
//                self.myMenuView.reloadData()
                var indexPaths = [IndexPath]()
                indexPaths.append(IndexPath(item: i, section: 0))
                self.myMenuView.reloadItems(at: indexPaths)
            }
//            print("responce: \(responce.urlPatch!)")
        }
        
        
    }
    
    
}
