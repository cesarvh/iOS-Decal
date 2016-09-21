//
//  AddNewFriendViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/6/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import Parse

class AddNewFriendViewController: UIViewController {
    
    @IBOutlet weak var newFriendBar: UITextField!
    
    //    var friendsArray : NSMutableArray = NSMutableArray()
    
    //    let friendsViewInstance = FriendsViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newFriendBar.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        checkUserExists(newFriendBar.text!)
        
    }
    
    func checkUserExists(username: String) {
        var query = PFUser.query()
        query!.whereKey("username", equalTo:username)
        do {
            //            try query?.getFirstObject()
            //                var friends = PFUser.currentUser()
            if (mainInstance.friendsArray.containsObject(username)) {
                let alertController = UIAlertController(title: "Error", message: "You already have this friend",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                try query?.getFirstObject()
                var friends = PFUser.currentUser()
                
                mainInstance.friendsArray.addObject(username)
                NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                
                friends!["friends"] = mainInstance.friendsArray
                friends!.saveInBackgroundWithBlock{
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("saved!")
                        self.navigationController?.popViewControllerAnimated(true)
                    } else {
                        print("something went wrong frown emoticon ")
                    }
                }
                
            }
            
        } catch {
            let alertController = UIAlertController(title: "Radius", message:
                "This user does not exist", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
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