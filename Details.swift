//
//  Details.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/3/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class Details: UIViewController
{

    var ID:Int = 0
    var pilgrims = Pilgrims()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nation: UILabel!
    @IBOutlet weak var passno: UILabel!
    @IBOutlet weak var makkah: UILabel!
    @IBOutlet weak var madinnah: UILabel!
    @IBOutlet weak var mina: UILabel!
    
    var mak: CLLocationCoordinate2D?
    var mad: CLLocationCoordinate2D?
    var min: Int?
    
    var choose:String?
    
    @IBAction func makClicked(_ sender: Any)
    {
        choose="mak"
    }
    
    @IBAction func madinahClicked(_ sender: Any)
    {
        choose="mad"
    }
    
    
    @IBAction func minaClicked(_ sender: Any)
    {
        choose="mina"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var p = pilgrims.Pilgrims[ID]
        name.text = p?.name
        nation.text = p?.nationality
        passno.text = p?.passportno
        makkah.text = p?.makkahname
        madinnah.text=p?.madinahname
        mina.text = "Mina's tent number: \(p?.tentno)"
        
        mak = CLLocationCoordinate2D(latitude: (p?.makkahlat)!,longitude: (p?.makkahlong)!)
        mad = CLLocationCoordinate2D(latitude: (p?.madinahlat)!,longitude: (p?.madinahlong)!)
        min = p?.tentno

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let x = segue.destination as! Map
        x.makkah = mak
        x.madinah = mad
        x.mina = min
        x.chose = choose
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
