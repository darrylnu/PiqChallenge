//
//  ChallengeViewController.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var challengeCount = [String]()
    var challengeName = [String]()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        navigationItem.hidesBackButton = true
        
        let challengeQuery = PFQuery(className: "Challenges")
        challengeQuery.whereKey("challenge", notEqualTo: "Choose Challenge")
        challengeQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            self.challengeName.removeAll(keepCapacity: true)
            self.challengeCount.removeAll(keepCapacity: true)
            
            if let object = object {
                for challenges in object {
                    
                    let countQuery = PFQuery(className: "Post")
                    countQuery.whereKey("imageComment", equalTo: challenges["challenge"])
                    countQuery.orderByDescending("createdAt")
                    countQuery.countObjectsInBackgroundWithBlock({ (count, error) -> Void in
                        self.challengeCount.append("\(count)")
                        self.challengeName.append(challenges["challenge"] as! String)
                        self.table.reloadData()
                    })
                }
            }
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return challengeCount.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("challengeCell", forIndexPath: indexPath) as! ChallengeCell
        
        // Configure the cell...
        
            cell.challengeCount.text = challengeCount[indexPath.row]
            cell.challengeStrip.text = "Users accepted the \(challengeName[indexPath.row]) challenge!"

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        pressedChallenge = challengeName[indexPath.row]
        
    }


}
