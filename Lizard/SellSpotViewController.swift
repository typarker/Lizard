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
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        
        var span = MKCoordinateSpanMake(0.025, 0.025)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        var annotation = CustomPointAnnotation()
        //var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Roatan"
        annotation.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation)
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 0.5;
        
        mapView.addGestureRecognizer(lpgr)
        
        //testing
        var info2 = CustomPointAnnotation()
        info2.coordinate = location
        info2.title = "Test Title2!"
        info2.subtitle = "Subtitle2"
        info2.imageName = "2.png"
        mapView.addAnnotation(info2)

    }
    
    //testing
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            
            if control == view.rightCalloutAccessoryView {
                println("Disclosure Pressed! \(view.annotation.subtitle)")
                
                if let cpa = view.annotation as? CustomPointAnnotation {
                    println("cpa.imageName = \(cpa.imageName)")
                }
            }
            
    }
    

    
 //long press annotation add
    func action(gestureRecognizer:UIGestureRecognizer) {
        //Remove any annotations
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        //Add new annotation
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        var view: MKAnnotationView
        
        var newAnotation = CustomPointAnnotation()
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
    

