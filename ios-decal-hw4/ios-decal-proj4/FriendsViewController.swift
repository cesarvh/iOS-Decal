//
//  FriendsViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/5/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import Parse

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var friendsTableView: UITableView!
    //    var friendsArray: NSMutableArray = NSMutableArray();
    //    var friendsArray:[String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendsTableView.delegate = self
        self.friendsTableView.dataSource = self
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
        friendsTableView.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        friendsTableView.separatorColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0)
        
        
        // Do any additional setup after loading the view.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.friendsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create cell
        let cell = self.friendsTableView.dequeueReusableCellWithIdentifier("friendCell")! as UITableViewCell
        //         customize
        cell.textLabel?.text = mainInstance.friendsArray[indexPath.row] as! String
        //        background: rgb(157, 212, 222);
        
        self.view.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        tableView.backgroundColor = UIColor(red:0.62, green:0.83, blue:0.87, alpha:1.0)
        tableView.separatorColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0)
        // return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // delete the friend on UI
            // delete the friend in the parse array
            //            var query = PFUser.query()
            //            query!.whereKey("username", equalTo:username)
            
            var byeFriend = mainInstance.friendsArray.objectAtIndex(indexPath.row)
            
            
            mainInstance.friendsArray.removeObjectAtIndex(indexPath.row)
            
            
            
            var query = PFQuery(className:"_User")
            query.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
                (friendsDatabase: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let friendsDatabase = friendsDatabase {
                    var temp = friendsDatabase["friends"] as! NSMutableArray
                    temp.removeObject(byeFriend)
                    friendsDatabase["friends"] = temp
                    friendsDatabase.saveInBackground()
                    
                }
            }
            
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return mainInstance.friendsArray.count
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