//
//  OrederStruct.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 15.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation
struct ItemOrder : Encodable{
  var id : String
  var amount : Int
}
struct Order : Encodable {
    var orders = [ItemOrder]()
    var name : String
    var adress : String
    var phone : String
}

struct DataOrderResponce : Decodable {
    var orderid : String
}
struct ResponceOrder : Decodable {
    var status : String
    var data: DataOrderResponce 
}
