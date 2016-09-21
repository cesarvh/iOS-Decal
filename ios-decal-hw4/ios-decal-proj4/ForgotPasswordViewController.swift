//
//  ForgotPasswordViewController.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/7/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        let query = PFUser.query()
        query?.whereKey("username", equalTo: usernameField.text!)
        do {
            let user = try query?.getFirstObject() as! PFUser
            //                user.password = newPassField.text!
            PFUser.requestPasswordResetForEmailInBackground(user.email!)
            
            let alert = UIAlertView(title: "Radius", message: "A reset link has been sent to your e-mail", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
        } catch {
            let alert = UIAlertView(title: "Radius", message: "Oops! Looks like this user doesn't exist", delegate: self, cancelButtonTitle: "Ok ")
            alert.show()
        }
        
        
    }
    //    PFUser *user = (PFUser *)[query getFirstObject];
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
