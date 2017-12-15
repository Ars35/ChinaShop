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
    var order = [ItemOrder]()
    var name : String
    var address : String
    var phone : String
}
//JSON засылать такой:
//{
//    "order": [
            //    {
            //    "id": "Z1KukSj",
            //    "amount": 3
            //    }
            //    ],
//    "name": "Alex",
//    "address": "Minsk Nezaleznasti 1",
//    "phone": "375 23 1234567"
//}

struct DataOrderResponce : Decodable {
    var orderId : String
}
struct ResponceOrder : Decodable {
    var status : String
    var data: DataOrderResponce?
}
//Ответ такой:
//{
//    "status": "success",
//    "data": {
//        "orderId": "Z1XlDkP"
//    }
//}

