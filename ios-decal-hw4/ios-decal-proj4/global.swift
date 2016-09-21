//
//  global.swift
//  ios-decal-proj4
//
//  Created by Cesar Villalobos on 12/7/15.
//  Copyright © 2015 Cesar Villalobos, Nag Alluri, Kelly Hong. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Parse

class Main {
    var name:String
    var friendsArray: NSMutableArray = NSMutableArray()
    
    init(name:String, friendsArray: NSMutableArray ) {
        self.name = name
        self.friendsArray = friendsArray
    }
}
var mainInstance = Main(name:"My Global Class", friendsArray: [])