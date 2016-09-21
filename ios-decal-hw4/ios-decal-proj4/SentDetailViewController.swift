//
//  SentDetailViewController.swift
//  ios-decal-proj4
//
//  Created by Nag Alluri on 12/7/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse


class SentDetailViewController: UIViewController {
    @IBOutlet weak var senttoTF: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var Map: MKMapView!
    
    var currentObject : PFObject?
    var currentReceiver: String?
    var currentMessage: String?
    var currentDate: NSDate?
    var currentgeoPoint: PFGeoPoint?
    var objectId: String?
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senttoTF.text = currentReceiver
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
        dateLabel.text = NSString(format: "%@", dateFormat.stringFromDate(currentDate!)) as String
        message.text = currentMessage
        latitude = currentgeoPoint!.latitude
        longitude = currentgeoPoint!.longitude
        let location = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let loc = CLLocation(latitude: latitude, longitude: longitude)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location
        dropPin.title = "Message Location"
        Map.addAnnotation(dropPin)
        centerMapOnLocation(loc)
//        
//        senttoTF.layer.cornerRadius = 10
//        dateLabel.layer.cornerRadius = 10
//        message.layer.cornerRadius = 10
        
        senttoTF.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        senttoTF.layer.borderWidth = 1.0;
        
        dateLabel.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        dateLabel.layer.borderWidth = 1.0;
        
        message.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        message.layer.borderWidth = 1.0;
        
            //currencyCode.text = object["currencyCode"] as! String

        // Do any additional setup after loading the view.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        Map.setRegion(coordinateRegion, animated: true)
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
