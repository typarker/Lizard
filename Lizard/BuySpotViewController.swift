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
            let lotAnnotation = LotAnnotation(coordinate: coord, title: aLot.price, subtitle: "Dollars", lot: aLot) // 3
            mapView.addAnnotation(lotAnnotation) // 4
            
        }
        
   

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
