//
//  SellSpotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/1/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//



import UIKit
import MapKit


class SellSpotViewController: UIViewController {
    
  
    @IBOutlet var DropPin: SellSpot!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = CLLocationCoordinate2D(
            latitude: 16.40,
            longitude: -86.34
        )
        
        var span = MKCoordinateSpanMake(0.5, 0.5)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Roatan"
        annotation.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation)
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 0.5;
        
        mapView.addGestureRecognizer(lpgr)
        
        

    }
 
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "New Location"
        newAnotation.subtitle = "New Subtitle"
        mapView.addAnnotation(newAnotation)
        
    }
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

