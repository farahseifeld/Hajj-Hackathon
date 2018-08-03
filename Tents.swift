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
    struct Tent
    {
        let lat: Double
        let long: Double
        let id: Int
    }
    
    var Tents = [Int : Tent]()
    
    var locations : [CLLocationCoordinate2D]=[]
    
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
    func getlocations()
    {
        let tents = self.load_data()?.tents
         if(tents != nil)
         {
            var i=0
            for tent in tents!
            {
                print("id: ", tent.id)
                print("lat: ", tent.lat)
                print("long: ", tent.long)
                Tents[tent.id] = Tent(lat: tent.lat, long: tent.long, id: tent.id)
                locations.insert(CLLocationCoordinate2D(latitude: tent.lat,longitude: tent.long), at: tent.id)
                //[tent.id] = CLLocationCoordinate2D(latitude: tent.lat,longitude: tent.long)
                i=i+1
            }
        }
    }
    override init()
    {
        super.init()
        let tents = self.load_data()?.tents
        if(tents != nil)
        {
            var i = 0
            for tent in tents!
            {
                print("id: ", tent.id)
                print("lat: ", tent.lat)
                print("long: ", tent.long)
                Tents[tent.id] = Tent(lat: tent.lat, long: tent.long, id: tent.id)
                i=i+1
            }
        }
        
        print(Tents.count)
        
    }
}
