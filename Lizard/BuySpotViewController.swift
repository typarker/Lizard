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
    
    let realm = RLMRealm(path:"/Users/typarker/Desktop/Lizard/Lots.realm")
    //let petsRealm = RLMRealm.realmWithPath("pets.realm")
    //let otherDogs = Dog.allObjectsInRealm(petsRealm)
    //let lots = Lot.allObjectsInRealm(realm)
    
    
    //var lots = RLMArray(objectClassName: Lot.className())
    func populateMap(){
        println(realm.path)
        mapView.removeAnnotations(mapView.annotations) // 1
        let lots = Lot.allObjectsInRealm(realm)        //var lots = Lots.allObjects()  // 2
        //println(lots)
        // Create annotations for each one
        for lot in lots {
            let aLot = lot as Lot
            let coord = CLLocationCoordinate2D(latitude: aLot.latitude, longitude: aLot.longitude);
            let lotAnnotation = LotAnnotation(coordinate: coord, title: String(aLot.spots), subtitle: "Dollars", lot: aLot) // 3
            mapView.addAnnotation(lotAnnotation) // 4
            
        }
        
   println(lots)

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
        
        let realm = RLMRealm(path:"/Users/typarker/Desktop/Lizard/Lots.realm")
       
        // Find objects
        //var localTypes = Lot.objectsWhere("id = 6879")
        var lots = Lot.allObjectsInRealm(realm)
        // Update one of those objects
        println(lots)
        realm.beginWriteTransaction()
        var existingForm = lots[0] as Lot
        existingForm.spots = existingForm.spots-1
        // Wrap up transaction
        realm.commitWriteTransaction()

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
