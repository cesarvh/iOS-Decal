//
//  MessagesViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/5/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//
import UIKit
import Parse
import ParseUI
import CoreLocation


class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var messageTableView: UITableView!
    
    var locManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var messagesArray: NSMutableArray = NSMutableArray()
    
    var unreadArray: NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTableView.reloadData()
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        //        self.messageTextField.delegate = self
        
        self.messagesArray.addObject("hi")
        self.messagesArray.addObject("bye")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
        loadMessages()
        for message in messagesArray {
            print(message)
        }
        loadDataFromParse()
        // Do any additional setup after loading the view.
    }
    
    func queryForTable() -> PFQuery {
        let query = PFQuery(className: "SentMessages")
        //        query.orderByAscending("objectId")
        return query
    }
    
    var objectIds: NSMutableArray = [] // empty string
    // currentObject, currentSender, currentMessage, objectID
    var messages: NSMutableArray = []
    var dates: NSMutableArray = []
    var senders: NSMutableArray = []
    
    func loadDataFromParse() {
        let query = PFQuery(className: "SentMessages")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                // print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                for object in objects! {
                    self.objectIds.addObject((object.objectId as String?)!)
                    self.dates.addObject((object.createdAt )!)
                    self.senders.addObject((object["senderName"] as! String?)!)
                }
                
                for msg in self.messagesArray {
                    self.messages.addObject(msg)
                }
            } else {
                print("\(error)")
            }
        }
        
    }
    
    func getLocation() {
        locManager.requestWhenInUseAuthorization()
        var currentLocation = CLLocation!()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                currentLocation = locManager.location
        }
        latitude = (currentLocation.coordinate.latitude)
        longitude = (currentLocation.coordinate.longitude)
    }
    
    func loadMessages() {
        // get the current user's messages
        // iterate through the ones that the user has already received
        // show the ones receiverName == currentUser and received = true and receiverName == currentUser and user location
        // is within some radius of the current location
        // aka append those messages to messagesArray
        //
        
        //        var geoPoint: PFGeoPoint
        //        query!.whereKey("username", equalTo:username)
        //        var currentUser = PFUser.currentUser()
        //        var message = PFObject(className:"SentMessages")
        // get location of the current user
        
        var geoPoint: PFGeoPoint
        getLocation()
        geoPoint = PFGeoPoint(latitude: latitude, longitude: longitude)
        
        let currentUser = PFUser.currentUser()
        let username = currentUser?.username
        print(username)
        
        let query2 = PFQuery(className: "SentMessages")
        query2.whereKey("receiverName", equalTo: username!)
        query2.whereKey("received", equalTo: false)
        // filter by within radius
        query2.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // get the location
                        // check to see if location is within some radius
                        // if it is, get the message and append it to the array
                        let object_location = object["messageLocation"] as! PFGeoPoint
                        let distance = geoPoint.distanceInMilesTo(object_location)
                        //                        let object_msg = object["Message"]
                        //                        print(object_msg)
                        if (distance <= 0.25) {
                            // get the message and append it to the array
                            let object_msg = object["Message"]
                            print(object_msg)
                            object["received"] = true
                            object.saveInBackground()
                            self.messagesArray.addObject(object_msg as! (String))
                            self.unreadArray.addObject(object_msg as! (String))

                            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                        }
                    }
                }
            } else {
                print("error")
            }
        }
        
        let query1 = PFQuery(className: "SentMessages")
        query1.whereKey("receiverName", equalTo: username!)
        // filter by received
        query1.whereKey("received", equalTo: true)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // get the message
                        // append it to messagesArray
                        let object_msg = object["Message"]
                        print(object_msg)
                        object.saveInBackground()
                        self.messagesArray.addObject(object_msg as! (String))
                        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                    }
                }
                
            } else {
                print("error")
            }
        }
    }
    
    
    func loadList(notification: NSNotification) {
        // load data here
        self.messageTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create cell
        let cell = self.messageTableView.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell
        //         customize
        cell.textLabel?.text = self.messagesArray[indexPath.row] as! String
        let string = cell.textLabel?.text
        if unreadArray.contains({$0 as! String==string!}) {
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(20.0)
        }
        //        background: rgb(157, 212, 222);
        
        self.view.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        tableView.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        tableView.separatorColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0)
        // return the cell
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesArray.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailScene = segue.destinationViewController as! MessageDetailViewController
        
        if let indexPath = self.messageTableView.indexPathForSelectedRow {
            let row = Int(indexPath.row)
            detailScene.objectId = (objectIds[row] as! String)
            detailScene.currentMessage = (messages[row] as! String)
            detailScene.currentDate = (dates[row] as! NSDate)
            detailScene.currentSender = (senders[row] as! String)
            
            
        }
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // delete the friend on UI
            // delete the friend in the parse array
            //            var query = PFUser.query()
            //            query!.whereKey("username", equalTo:username)
            
            var byeMsg = messagesArray.objectAtIndex(indexPath.row)
            //
            //
            //            messagesArray.removeObjectAtIndex(indexPath.row)
            //
            //
            //
            //            var query = PFQuery(className:"SentMessages")
            //            do {
            //                var messagesDB = try query.findObjects()
            //                if (var editableMessagesFromDB = messagesDB as! NSMutableArray) {
            //
            //                }
            //
            //                var i = 0
            //                while (i != editableMessagesFromDB.count) {
            //                    if (editableMessagesFromDB[i]["Message"] as! String == byeMsg as! String) {
            //                        editableMessagesFromDB.removeObjectAtIndex(i)
            //                        messagesDB = editableMessagesFromDB
            //
            //                    }
            //                    return;
            //                    i += 1
            //                }
            //
            //            } catch {
            //                print("nah")
            //            }
            ////
            //            query.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
            //                (friendsDatabase: PFObject?, error: NSError?) -> Void in
            //                if error != nil {
            //                    print(error)
            //                } else if let friendsDatabase = friendsDatabase {
            //                    var temp = friendsDatabase["friends"] as! NSMutableArray
            //                    temp.removeObject(byeFriend)
            //                    friendsDatabase["friends"] = temp
            //                    friendsDatabase.saveInBackground()
            //
            //                }
            //            }
            
            //
            //
            //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //
            //
            //            
        }
    }
    
    
    
    // get current location, filter database by receiverName
    // show up messages within some kind of location
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
