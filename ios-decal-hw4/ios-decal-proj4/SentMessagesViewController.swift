//
//  SentMessagesViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/5/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit

class SentMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    var sentMessagesArray:[String] = [String]()

    
    @IBOutlet weak var sentMessages: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sentMessages.delegate = self
        self.sentMessages.dataSource = self
        
        //        self.messageTextField.delegate = self
        
        self.sentMessagesArray.append("message 1")
        self.sentMessagesArray.append("message 2")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create cell
        let cell = self.sentMessages.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell
        //         customize
        cell.textLabel?.text = self.sentMessagesArray[indexPath.row]
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
        
        
        return sentMessagesArray.count
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
