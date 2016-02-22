//
//  FeedTableViewController.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var usersBeingFollowed = [String]()
    var imageFiles = [PFFile]()
    var imageComment = [""]
    var usernames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let getCurrentUser = PFQuery(className: "Post")
        getCurrentUser.whereKey("userId", equalTo: (PFUser.currentUser()?.objectId)!)
        getCurrentUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            self.usernames.removeAll(keepCapacity: true)
            self.imageComment.removeAll(keepCapacity: true)
            self.imageFiles.removeAll(keepCapacity: true)
            

            if let objects = object {
                
                for images in objects {
                    
                    
                    self.imageFiles.append(images["imageFile"] as! PFFile)
                    self.imageComment.append(images["imageComment"] as! String)
                    self.usernames.append((PFUser.currentUser()?.username)!)
                }
                

        }
        }

        
        let getFollowedUsersQuery = PFQuery(className: "Followers")
        
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            self.usersBeingFollowed.removeAll(keepCapacity: true)

            
            if let objects = objects {
                
                for object in objects {
                    
                    let followedUser = object["following"] as! String
                    
                    let getFollowedUsers = PFQuery(className: "Post")
                    
                    getFollowedUsers.whereKey("userId", equalTo: followedUser)
                    
                    
                    getFollowedUsers.findObjectsInBackgroundWithBlock({ (imageObjects, error) -> Void in
                        
                        
                        if let objects = imageObjects {
                            
                            for images in objects {
                                
                                
                                self.imageFiles.append(images["imageFile"] as! PFFile)
                                self.imageComment.append(images["imageComment"] as! String)
//                                print(self.imageComment.count)
                                

                                
                                let userQuery = PFUser.query()
                                userQuery?.whereKey("_id", equalTo: images["userId"])
                                userQuery?.findObjectsInBackgroundWithBlock({ (user, error) -> Void in
                                    if let user = user {
                                        for username in user {
                                            self.usernames.append(username["username"] as! String)
                                            
                                            self.tableView.reloadData()

                                        }
                                        
                                    }
                                    
                                })
                                
                                

                                
                            }
                            

 
                        }

              
                    })


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
        let myCell = tableView.dequeueReusableCellWithIdentifier("imagePostCell", forIndexPath: indexPath) as! cell
                
        if imageComment.count > 0{
            myCell.userLabel.text = "\(usernames[indexPath.row]) completed the \(imageComment[indexPath.row]) challenge!"
            imageFiles[indexPath.row].getDataInBackgroundWithBlock({ (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    
                    myCell.imagePost.image = downloadedImage

                }
            })
        }
        
        return myCell
    }

   }
