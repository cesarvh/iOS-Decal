//
//  NewMessageViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/5/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class NewMessageViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newMessageField: UITextField!
    
    
    var locManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        newMessageField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation() {
        locManager.requestWhenInUseAuthorization()
        var currentLocation = CLLocation!()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                currentLocation = locManager.location
        }
        latitude = (currentLocation.coordinate.latitude)
        longitude = (currentLocation.coordinate.longitude)
    }
    
    
    

    @IBAction func sendAction(sender: AnyObject) {
        var geoPoint: PFGeoPoint 
        var currentUser = PFUser.currentUser()
        var message = PFObject(className:"SentMessages")
        message["Message"] = newMessageField.text
        message["receiverName"] = searchBar.text
        message["senderName"] = currentUser?.username
        getLocation()
        geoPoint = PFGeoPoint(latitude: latitude, longitude: longitude)
        message["messageLocation"] = geoPoint
        message["received"] = false
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                let alert = UIAlertView(title: "Success", message: "Message Successfully Sent", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            } else {
                let alert = UIAlertView(title: "Error", message: "Could Not Send Message", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        newMessageField.text = ""
        searchBar.text = ""
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
