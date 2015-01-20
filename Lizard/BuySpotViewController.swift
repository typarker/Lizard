//
//  BuySpotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/8/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit
import MapKit
import Realm

class BuySpotViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    
    //set Realm
    //let realm = RLMRealm(path:"/Users/typarker/Desktop/Lizard/Lots.realm")
    
    
    
    
    //add annotations to map
    func populateMap(){
        mapView.removeAnnotations(mapView.annotations) // 1
        //let lots = Lot.allObjectsInRealm(realm)
        //var lotWithSpot = lots.objectsWhere("spots > 0")
        
        
        var query = PFQuery(className:"MyLotParse")
        query.whereKey("spots", greaterThan: 0)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) spots.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    let latitude = object["latitude"] as Double
                    let longitude = object["longitude"] as Double
                    let price = object["price"] as String
                    let owner = object["owner"] as PFUser?
                    let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let id = object.objectId
                    let lotAnnotation = LotAnnotation(coordinate: coord, title: price, subtitle: "Dollars", id: id, owner: owner!) // 3
                    self.mapView.addAnnotation(lotAnnotation) // 4
                   
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        //println(lots)
        // Create annotations for each one
        /*for lot in lotWithSpot {
            let aLot = lot as Lot
            let coord = CLLocationCoordinate2D(latitude: aLot.latitude, longitude: aLot.longitude);
            let lotAnnotation = LotAnnotation(coordinate: coord, title: String(aLot.price), subtitle: "Dollars", lot: aLot, id: aLot.id) // 3
            mapView.addAnnotation(lotAnnotation) // 4
            
        }
        
   println(lotWithSpot)
*/
    }
    
    func mapView(_mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        //if !(annotation is MKPointAnnotation) {
        //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
        //return nil so map draws default view for it (eg. blue dot)...
        // return nil
        // }
        //let textbox : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
        //textbox.text = "blah"
        let reuseId = "test"
        let button : UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.image = UIImage(named:"redPin.png")
            anView.canShowCallout = true
            
            
            //anView.leftCalloutAccessoryView = textbox
            
            //price = self.textbox.text
            anView.rightCalloutAccessoryView = button
            
            button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView.annotation = annotation
        }
        
        return anView
    }
    
    func buttonClicked(sender: UIButton!) {
        
       

        
        // Get info about currently selected annotation
       let ann = self.mapView.selectedAnnotations[0] as LotAnnotation
        // Find objects

        
        var query = PFQuery(className:"MyLotParse")
        query.getObjectInBackgroundWithId(ann.id) {
            (myLotParse: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            }
            else {
                
                //send push to seller
                let message: NSString = "Some Dude Bought Your Spot"
                
                var data = [ "title": "Some Title",
                    "alert": message]
                let owner = ann.owner
                
//                var username = myLotParse.objectForKey("user") as? String
//                println(username)
//                var userQuery = PFQuery(className:"User")
//                userQuery.whereKey("username" , equalTo: username)
//                var userObject = userQuery.getFirstObject()
//                var userId = userObject.objectForKey("objectId") as? String
                var installQuery = PFQuery(className: "Installation")
                installQuery.whereKey("user" , equalTo: owner)
                //var installation = installQuery.getFirstObject()
                //var installId = installation.objectForKey("installationId") as? String
                
                var push: PFPush = PFPush()
                push.setQuery(installQuery)
                push.setData(data)
                push.sendPushInBackground()
                
                
                
                //var query: PFQuery = PFInstallation.query()
                
                //remove a spot
                myLotParse.incrementKey("spots", byAmount: -1)
                myLotParse.saveInBackground()
                
                
            }
        }
        populateMap() //Reloads the map view before opening Thank You page
        performSegueWithIdentifier("buySpot", sender: sender)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        // 2
        let span = MKCoordinateSpanMake(0.025, 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        populateMap()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
