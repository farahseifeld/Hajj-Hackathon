//
//  Pay.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/3/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import UIKit

class Pay: UIViewController
{

    @IBOutlet weak var amount: UITextField!
    var amounttopay:Double?
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func scanClicked(_ sender: Any)
    {
        amounttopay = Double((amount.text! as NSString).doubleValue)
        performSegue(withIdentifier: "scan", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let x = segue.destination as! scancode
        x.amount = amounttopay

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(amount.text!)
        btn.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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

