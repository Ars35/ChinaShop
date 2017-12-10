//
//  SpecialsService.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 05.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

class SpecialService {
    
    static let instance = SpecialService()
    var spesialList = [SpecialItemStruct]()
    func getSpecialList(completion: @escaping (String) -> ()) {
        let urlString : String = "https://sushiserver.herokuapp.com/specials"
        let url = URL(string : urlString)
        URLSession.shared.dataTask(with: url!){
            (data , responce , error)
            in
            guard let data = data else {
                completion("ERROR IN DATA")
                return
            }
            var json : SpecialsStruct?
            var errorMessage: String = ""
            do{
                json = try JSONDecoder().decode(SpecialsStruct.self, from: data)
            }
            catch let parseError as NSError{
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                print(errorMessage)
                return
            }
//            print(json)
            for special in (json?.data.specials)!{
                let spesialItem = SpecialItemStruct(_id: special._id, name: special.name, itemId: special.itemId, description: special.description, imageUrl: special.imageUrl!)
                self.spesialList.append(spesialItem)
            }
            completion("PARSING OK")
            }.resume()
        
    }
}
