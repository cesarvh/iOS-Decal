//  InstagramAPI.Swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class InstagramAPI {
    /* Connects with the Instagram API and pulls resources from the server. */
    func loadPhotos(completion: (([Photo]) -> Void)!) {
        
        /*
        * 1. Get the endpoint URL to the popular photos DOOOOOONE
        *    HINT: Look in Utils
        * 2. Create a Session DONE????
        * 3. Create a Data Task with a URL and completionHandler
        *    If no error:
        *       a. Get NSDictionary from the JSON object, from key the "photos" DOOOOOONE
        *       b. Create Array of NSDictionaries (one NSDictionary for each photo) done
        *       c. For each NSDictionary, create a Photo object, and add to Photos array done
        *       d. Wait for completion of Photos array DONE
        */
        
        var url : NSURL
        var photoData = NSArray()
        var photoDictionary = NSDictionary()
        
        url = Utils.getPopularURL()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                var photos = [Photo]() // create a photo array
                do {
                    // 3ab:
                    photoDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    photoData = photoDictionary.valueForKey("data") as! NSArray
                    // 3c
                    for p in photoData {
                        photos.append(Photo(data: p as! NSDictionary))
                    }
                    
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(photos)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}