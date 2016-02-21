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
        
        for challenges in CameraViewController().challengeSource {
            
            if challenges != "Choose Challenge" {
            
            var query = PFQuery(className: "Post")
            query.whereKey("imageComment", equalTo: challenges)
            query.countObjectsInBackgroundWithBlock({ (count, error) -> Void in
                if error == nil {
                   
                    self.challengeCount.append(String(count))
                    self.challengeName.append(challenges)
                    self.table.reloadData()

                    
                } else {
                    print(error)
                }
            })
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
//            print(challengeCountStorage)
        
//        cell.textLabel?.text = "test"
//        print(challengeCountStorage.count)
        
        return cell
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
