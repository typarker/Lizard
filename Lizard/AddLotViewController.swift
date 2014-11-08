//
//  AddLotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/8/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit
import Realm

class lot: RLMObject {
    dynamic var spots = ""
    dynamic var price = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var created = NSDate()
}


class AddLotViewController: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var price: UITextField!
    @IBAction func sellSpot(sender: UIButton) {
        
        var myLot = Lot()
        
        // Set & read properties
        //myLot.spots = self.spots
        myLot.price = self.price.text
        myLot.latitude = self.latitude
        myLot.longitude = self.longitude
        
        println(RLMRealm.defaultRealm().path)
        
        // Realms are used to group data together
        let realm = RLMRealm.defaultRealm() // Create realm pointing to default file
        
        // Save your object
        realm.beginWriteTransaction()
        realm.addObject(myLot)
        realm.commitWriteTransaction()
    }
    
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

