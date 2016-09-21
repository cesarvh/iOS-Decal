//
//  TableViewController.swift
//  ios-decal-proj4
//
//  Created by Nag Alluri on 12/7/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewController: PFQueryTableViewController {
    
    //var objids:NSMutableArray = []
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
        parseClassName = "SentMessages"
        pullToRefreshEnabled = true
        paginationEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "SentMessages"
        self.textKey = "objectId"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromParse()

        
        self.tableView.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        self.tableView.separatorColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "SentMessages")
        query.orderByAscending("objectId")
        return query
    }
    
    var objectIds:NSMutableArray = [] // empty string array
    var messages:NSMutableArray = []
    var geopoints:NSMutableArray = []
    var dates:NSMutableArray = []
    var receivers:NSMutableArray = []
    func loadDataFromParse () {
        let query = PFQuery(className:"SentMessages")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                // print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                for object in objects! {
                    self.objectIds.addObject((object.objectId as String?)!)
                    self.messages.addObject((object["Message"] as! String?)!)
                    self.geopoints.addObject((object["messageLocation"] as! PFGeoPoint?)!)
                    self.dates.addObject((object.createdAt )!)
                    self.receivers.addObject((object["receiverName"] as! String?)!)
                }
            } else {
                print("\(error)")
            }
            
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        if cell == nil {
            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            cell!.textLabel?.text = object["receiverName"] as? String
            let priority = object["Message"] as? String
            cell!.detailTextLabel?.text = "Priority \(priority)"
        }
        
        self.view.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell!.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell!.textLabel?.textColor = UIColor.whiteColor()
        
        tableView.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        tableView.separatorColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0)
        
        return cell!
    }
    
//    override func queryForTable() -> PFQuery {
//        let query = PFQuery(className: "SentMessages")
//        query.whereKey("senderName", equalTo:(PFUser.currentUser()?.username)!)
//        query.orderByDescending("createdAt")
//        return query
//    }

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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        let detailScene = segue.destinationViewController as! SentDetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let row = Int(indexPath.row)
            detailScene.objectId = (objectIds[row] as! String)
            detailScene.currentMessage = (messages[row] as! String)
            detailScene.currentDate = (dates[row] as! NSDate)
            detailScene.currentgeoPoint = (geopoints[row] as! PFGeoPoint)
            detailScene.currentReceiver = (receivers[row] as! String)
            
            
        }
    }

}
