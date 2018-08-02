//
//  Tents.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/2/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class Tents: NSObject
{
    struct Json: Decodable
    {
        let tents: [T]
    }
    
    struct T: Decodable
    {
        let lat: Double
        let long: Double
        let id: Int
    }
    struct Station_Distance
    {
        let id: Int
        let distance: Double
    }
    struct Tent
    {
        let lat: Double
        let long: Double
        let id: Int
    }
    var Tents = [Int : Tent]()
    
    
    func load_data() -> Json?
    {
        if let path = Bundle.main.path(forResource: "tents", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Json.self, from: data)
                
                return jsonData
                
            } catch
            {
                // handle error
            }
        }
        return nil
    }
    override init()
    {
        super.init()
        let tents = self.load_data()?.tents
        if(tents != nil)
        {
            for tent in tents!
            {
                print("id: ", tent.id)
                print("lat: ", tent.lat)
                print("long: ", tent.long)
                Tents[tent.id] = Tent(lat: tent.lat, long: tent.long, id: tent.id)
                
            }
        }
        
        print(Tents.count)
        
    }
}
