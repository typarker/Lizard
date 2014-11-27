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
    //@IBOutlet var textbox : UITextField!
    @IBOutlet weak var mapView: MKMapView!
    //var price: String = ""
    var coordToPass = CLLocationCoordinate2D(
        latitude: 0,
        longitude: 0
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        
        var span = MKCoordinateSpanMake(0.025, 0.025)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
   
       populateMap()
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 0.5;
        
        mapView.addGestureRecognizer(lpgr)
        
        
       

    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "goToAddLot"{
            var newProjectVC:AddLotViewController = AddLotViewController()
             newProjectVC = segue.destinationViewController as AddLotViewController
            newProjectVC.latitude = self.coordToPass.latitude
            newProjectVC.longitude = self.coordToPass.longitude
        }
    }
   
    
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
    
        //long press annotation add
    
        func action(gestureRecognizer:UIGestureRecognizer) {
        //Remove any annotations
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        //Add new annotation
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            var info2 = MapPin(coordinate: newCoord,title: "Your Yard",subtitle: "")
        //var anView:MKAnnotationView! = mapView(self.mapView, viewForAnnotation: info2)
        self.mapView.addAnnotation(info2)
            coordToPass=newCoord
        
    }
    // Do any additional setup after loading the view.
    
    
    func buttonClicked(sender: UIButton!) {
        
        //let secondViewController:AddLotViewController = AddLotViewController()
        
        //self.presentViewController(secondViewController, animated: true, completion: nil)
        performSegueWithIdentifier("goToAddLot", sender: sender)
        
    }
    
    
    //add annotations to map
    func populateMap(){
        mapView.removeAnnotations(mapView.annotations) // 1
  
        var user = PFUser.currentUser()
        
        var query = PFQuery(className:"MyLotParse")
        query.whereKey("user", equalTo: user.username)
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
                    let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let id = object.objectId
                    let lotAnnotation = LotAnnotation(coordinate: coord, title: price, subtitle: "Dollars", id: id) // 3
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
    

