//
//  TrendingChallengeTableViewController.swift
//  PiqChallenge
//
//  Created by Darryl Nunn on 2/22/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var pressedChallenge: String?

class TrendingChallengeTableViewController: UITableViewController {
    
    var images = [PFFile]()
    var usernames = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        let query = PFQuery(className: "Post")
        query.whereKey("imageComment", equalTo: pressedChallenge!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            self.usernames.removeAll(keepCapacity: true)
            self.images.removeAll(keepCapacity: true)
            
            if let object = object {
                for images in object {
                    self.images.append(images["imageFile"] as! PFFile)
                    self.usernames.append(images["username"] as! String)
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let trendCell = tableView.dequeueReusableCellWithIdentifier("trendingCell", forIndexPath: indexPath) as! TrendingChallengeTableViewCell
        
        if images.count > 0 {
        
         trendCell.postComment.text = "\(usernames[indexPath.row]) completed the \(pressedChallenge!) challenge!"
        
        images[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
              trendCell.postImage.image = downloadedImage
            } else {
                print(error)
            }

        }
        }
        
       
        
        return trendCell
    }
    
    
}
