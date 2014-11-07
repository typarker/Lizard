//
//  SellSpotViewController.swift
//  Lizard
//
//  Created by Ty Parker on 11/1/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//



import UIKit
import MapKit


class SellSpotViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet var DropPin: SellSpot!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        
        var span = MKCoordinateSpanMake(0.025, 0.025)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
       
        //var annotation = MKPointAnnotation()
        //annotation.setCoordinate(location)
       // annotation.title = "Roatan"
       // annotation.subtitle = "Honduras"
        
        //self.mapView.addAnnotation(annotation)
       
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 0.5;
        
        mapView.addGestureRecognizer(lpgr)
        
        //testing
       

    }
    
    //testing
    
    class MapPin : NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String
        var subtitle: String
        
        
        init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
        }
    }
    
    
    func mapView(_mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        //if !(annotation is MKPointAnnotation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
           // return nil
       // }
            let price : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
            let reuseId = "test"
           let button : UIButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.image = UIImage(named:"redPin.png")
            anView.canShowCallout = true
          
            
            anView.leftCalloutAccessoryView = price
            anView.rightCalloutAccessoryView = button
            button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
           
            
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView.annotation = annotation
        }
        
        return anView
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
        var info2 = MapPin(coordinate: newCoord,title: "title",subtitle: "poop")
        //var anView:MKAnnotationView! = mapView(self.mapView, viewForAnnotation: info2)
        self.mapView.addAnnotation(info2)
        
    }
    // Do any additional setup after loading the view.
    
    
    func buttonClicked(sender: UIButton!) {
     println("fuck yeah mother fucker")
        
    }
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
    

