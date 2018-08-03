//
//  Pilgrims.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/3/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import Foundation

class Pilgrims: NSObject
{
    struct Json: Decodable
    {
        let pilgrims: [P]
    }
    
    struct P: Decodable
    {
       let id:Int
       let name:String
       let nationality:String
       let passportno:String
       let makkahname:String
       let makkahlat: Double
       let makkahlong: Double
       let madinahname:String
       let madinahlat:Double
       let madinahlong:Double
       let tentno: Int
       let balance: Double
    }
    struct Pilgrim
    {
        let id:Int
        let name:String
        let nationality:String
        let passportno:String
        let makkahname:String
        let makkahlat: Double
        let makkahlong: Double
        let madinahname:String
        let madinahlat:Double
        let madinahlong:Double
        let tentno: Int
        var balance: Double
    }
    
    var Pilgrims = [Int : Pilgrim]()
    
    func load_data() -> Json?
    {
        if let path = Bundle.main.path(forResource: "pilgrims", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Json.self, from: data)
                
                return jsonData
                
            } catch
            {
                // handle error
                print("CANNOT LOAD PILGRIMS JSON ")
            }
        }
        return nil
    }
    
    override init()
    {
        super.init()
        let pil = self.load_data()?.pilgrims
        if(pil != nil)
        {
            var i = 0
            for p in pil!
            {
                print("             PILGRIMS             ")
                print("id: ", p.id)
                print("name: ", p.name)
                print("nationality: ", p.nationality)
                print("passportno", p.passportno)
                
                Pilgrims[p.id] = Pilgrim(id: p.id, name: p.name, nationality: p.nationality, passportno: p.passportno, makkahname: p.madinahname, makkahlat: p.makkahlat, makkahlong: p.makkahlong, madinahname: p.makkahname, madinahlat: p.madinahlat, madinahlong: p.madinahlong, tentno: p.tentno, balance: p.balance)
                i=i+1
            }
        }
        
        print(Pilgrims.count)
        
    }
    
}
