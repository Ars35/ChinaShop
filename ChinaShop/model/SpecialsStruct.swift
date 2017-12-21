//
//  SpecialsStruct.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 09.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

//{
//    "_id": "5a2259391a9db30014f2b3fc",
//    "name": "Happy Hour",
//    "itemId": "SpxAg",
//    "description": "MON-FRI 15.00-17.00",
//    "imageUrl": "http://res.cloudinary.com/hqwr3xrqp/image/upload/v1512200505/pkxbflon53mq5na1c8pt.jpg"
//}
import Foundation
struct SpecialItemStruct : Decodable{
    var _id :String?
    var name : String?
    var itemId : String?
    var description : String?
    var imageUrl: String?
    
}
struct DataSpecialsStruct : Decodable{
    var specials = [SpecialItemStruct]()
    
}
struct SpecialsStruct : Decodable{
    var status : String
    var data : DataSpecialsStruct
}
