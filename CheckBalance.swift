//
//  CheckBalance.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/3/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import UIKit

class CheckBalance: UIViewController
{

    var success:Bool?
    
    @IBOutlet weak var respose: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(success==true)
        {
            respose.text = "Successful Transaction"
            respose.backgroundColor = .green
        }
        else
        {
            respose.text = "Transaction failed"
            respose.backgroundColor = .red
        }
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
