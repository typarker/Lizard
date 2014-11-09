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

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = RLMRealm(path:"/Users/typarker/Desktop/Lizard/Lots.realm")
        var results = Lot.allObjects()
        
        //println(results)
        // 1
        let location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        // 2
        let span = MKCoordinateSpanMake(0.025, 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
       
        
        for var index = 0; index < 5; ++index {
            let annotation = MKPointAnnotation()
            var loc = CLLocationCoordinate2D(
                latitude: [index]Lot.latitude,
                longitude: Lot.longitude
                )
            annotation.setCoordinate(location)
            annotation.title = Lot.price
            annotation.subtitle = "Dollars"
            mapView.addAnnotation(annotation)
            
        }
     
    

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
