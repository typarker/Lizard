//
//  AddLotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/8/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit
import Realm




class AddLotViewController: UIViewController, PFLogInViewControllerDelegate  {
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var price: UITextField!
    @IBAction func sellSpot(sender: UIButton) {
        
        var myLot = Lot()
        
        // Set & read properties
        //myLot.spots = self.spots
        myLot.price = self.price.text
        myLot.latitude = self.latitude
        myLot.longitude = self.longitude
        
        
        //Write to realm
        
        // Realms are used to group data together
        //let realm = RLMRealm.defaultRealm() // Create realm pointing to default file
        /*let realm = RLMRealm(path:"/Users/typarker/Desktop/Lizard/Lots.realm")
        println(realm.path)
        // Save your object
        realm.beginWriteTransaction()
        realm.addObject(myLot)
        realm.commitWriteTransaction()*/
        
        var user = PFUser.currentUser()
        var myLotParse = PFObject(className: "MyLotParse")
        myLotParse.setObject(self.latitude, forKey: "latitude")
        myLotParse.setObject(self.longitude, forKey: "longitude")
        myLotParse.setObject(1, forKey: "spots")
        myLotParse.setObject(self.price.text, forKey: "price")
        myLotParse.setObject(user.username, forKey: "user")
        myLotParse.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if true {
                NSLog("Object created with id: \(myLotParse.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
        
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

