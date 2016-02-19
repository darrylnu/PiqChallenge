//
//  TableViewController.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/16/16.
//  Copyright © 2016 Nunnotha. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    
    
    var refresher: UIRefreshControl!
    
    var usernames = [""]
    var userIds = [""]
    var userPics = [String:PFFile]()
    var isFollowing = ["":false]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.hidesBackButton = true
        
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        refresh()
        
        
    }
    
    func refresh (){
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
            if let users = object {
                
                self.usernames.removeAll(keepCapacity: true)
                self.userIds.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                self.userPics.removeAll(keepCapacity: true)
                
                for objects in users {
                    if let user = objects as? PFUser {
                        
                        if let currentUser = PFUser.currentUser() {
                            
                            if user.objectId != currentUser.objectId {
                                
                                self.usernames.append(user.username!)
                                self.userIds.append(user.objectId!)
                                if let image = user["profileImage"] {
                                    self.userPics[user.objectId!] = image as? PFFile
                                }
                                
                                
                                
                                var query = PFQuery(className: "Followers")
                                query.whereKey("following", equalTo: user.objectId!)
                                query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
                                query.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                    if let object = object {
                                        
                                        if object.count > 0 {
                                            
                                            self.isFollowing[user.objectId!] = true
                                            
                                        } else {
                                            self.isFollowing[user.objectId!] = false
                                        }
                                    }
                                    if self.isFollowing.count == self.usernames.count {
                                        
                                        self.tableView.reloadData()
                                        self.refresher.endRefreshing()
                                        
                                    }
                                })
                            }
                            
                        }
                        
                        
                    }
                }
                
            }
            
        })
        
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
        return userIds.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UsersTableViewCell
        
        cell.userImage.frame = CGRectMake(0, 0, 100, 100)
        cell.userImage.clipsToBounds = true
        cell.userImage.layer.cornerRadius =  cell.userImage.frame.height/2
//        print(userPics[userIds[indexPath.row]], indexPath.row)
        
        
        if userPics[userIds[indexPath.row]] != nil {
            userPics[userIds[indexPath.row]]!.getDataInBackgroundWithBlock { (data, error) -> Void in
                if let data = data {
                    cell.userImage.image = UIImage(data: data)
                }
            }
        }
        
        // Configure the cell...
        cell.userLabel.text = usernames[indexPath.row]
        if isFollowing[userIds[indexPath.row]] == true {
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        print(userPics[userIds[indexPath.row]], "this is userpics at the row")
        
        print(userPics.count, "this is userpics count")
        
        
        if isFollowing[userIds[indexPath.row]] == false {
            
            isFollowing[userIds[indexPath.row]] = true
            
            var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var following = PFObject(className: "Followers")
            following["following"] = userIds[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId
            
            following.saveInBackground()
        } else {
            
            isFollowing[userIds[indexPath.row]] = false
            
            var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className: "Followers")
            query.whereKey("following", equalTo: userIds[indexPath.row])
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
            
            query.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                if let object = object {
                    for users in object {
                        users.deleteInBackground()
                    }
                }
            })
            
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
    
}
