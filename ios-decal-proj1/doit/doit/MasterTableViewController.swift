//
//  MasterTableViewController.swift
//  doit
//
//  Created by Cesar Villalobos on 10/13/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var toDoItems:NSMutableArray = NSMutableArray();
    

    
    override func viewDidAppear(animated: Bool) {
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        if itemListFromUserDefaults != nil {
            toDoItems = itemListFromUserDefaults!
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        var toDoItem:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as! NSDictionary
        cell.textLabel!.text = toDoItem.objectForKey("itemTitel") as? String
        
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
//        if (segue != nil && segue!.identifier == "schowDetail"){
//            var selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
//            var detailViewController:DetailViewController = segue!.destinationViewController as! DetailViewController
//            detailViewController.toDoData = toDoItems.objectAtIndex(selectedIndexPath.row) as! NSDictionary
//        }
//    }
}