//
//  SpecialsStruct.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 09.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation
struct SpecialItemStruct : Decodable{
    var _id :String
    var name : String
    var itemId : String
    var description : String
    var imageUrl: String?
    
}
struct DataSpecialsStruct : Decodable{
    var data = [SpecialItemStruct]()
    
}
struct SpecialsStruct : Decodable{
    var responce : String
    var specials : DataSpecialsStruct
}
