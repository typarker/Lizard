//
//  AddLotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/8/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit


class AddLotViewController: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    
    var latitude:Double!
    var longitude:Double!
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //colorLabel.text = latitude
        println(self.latitude)
        println(self.longitude)
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

