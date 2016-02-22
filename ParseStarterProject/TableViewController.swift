

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
        
        navigationItem.hidesBackButton = true
        
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        refresh()
        
        
    }
    
    func refresh (){
        
        let query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
            if let users = object {
                
                self.usernames.removeAll(keepCapacity: true)
                self.userIds.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                self.userPics.removeAll(keepCapacity: true)
                
                for objects in users {
                    if let user = objects as? PFUser {
                        
                        
                            if user.objectId != PFUser.currentUser()?.objectId {
                                
                                self.usernames.append(user.username!)
                                self.userIds.append(user.objectId!)
                                
                                if let image = user["profileImage"] {
                                    self.userPics[user.objectId!] = image as? PFFile
                                }
                                
                                
                                
                                let query = PFQuery(className: "Followers")
                                query.whereKey("following", equalTo: user.objectId!)
                                query.whereKey("follower", equalTo: (PFUser.currentUser()!.objectId)!)
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
        return usernames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UsersTableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UsersTableViewCell
        
        cell.userLabel.text = usernames[indexPath.row]
        if isFollowing[userIds[indexPath.row]] == true {
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        cell.userImage.frame = CGRectMake(0, 0, 100, 100)
        cell.userImage.clipsToBounds = true
        cell.userImage.layer.cornerRadius =  cell.userImage.frame.height/2
        
        if userPics[userIds[indexPath.row]] != nil {
            userPics[userIds[indexPath.row]]!.getDataInBackgroundWithBlock { (data, error) -> Void in
                if let data = data {
                    cell.userImage.image = UIImage(data: data)
                }
            }
        }
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell: UsersTableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as! UsersTableViewCell
        
        if isFollowing[userIds[indexPath.row]] == false {
            
            isFollowing[userIds[indexPath.row]] = true
            
           
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let following = PFObject(className: "Followers")
            following["following"] = userIds[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId
            
            following.saveInBackground()
        } else {
            
            isFollowing[userIds[indexPath.row]] = false
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            let query = PFQuery(className: "Followers")
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
    
}
