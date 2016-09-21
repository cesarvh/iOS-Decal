//
//  MessageDetailViewController.swift
//  ios-decal-proj4
//
//  Created by Kelly Hong on 12/7/15
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class MessageDetailViewController: UIViewController {
    @IBOutlet weak var sentBy: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    
    var currentObject : PFObject?
    var currentSender: String?
    var currentMessage: String?
    var objectId: String?
    var currentDate: NSDate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sentBy.text = currentSender
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
        dateLabel.text = NSString(format: "%@", dateFormat.stringFromDate(currentDate!)) as String
        message.text = currentMessage
        
        
        
        sentBy.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        sentBy.layer.borderWidth = 1.0;
        
        dateLabel.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        dateLabel.layer.borderWidth = 1.0;
        
        message.layer.borderColor = UIColor(red:0.50, green:0.62, blue:0.75, alpha:1.0).CGColor
        message.layer.borderWidth = 1.0;
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
