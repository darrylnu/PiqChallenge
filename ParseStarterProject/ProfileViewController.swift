//
//  ProfileViewController.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var username: UILabel!
    @IBOutlet var challengesCount: UILabel!
    
    @IBOutlet var followingCount: UILabel!
    @IBOutlet var followersCount: UILabel!
    
    @IBAction func changeProfilePic(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = true
        
        var alert = UIAlertController(title: "Choose Upload Source", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.view.tintColor = UIColor.redColor()
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            image.sourceType = UIImagePickerControllerSourceType.Camera
            alert.dismissViewControllerAnimated(true, completion: nil)
            self.presentViewController(image, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            alert.dismissViewControllerAnimated(true, completion: nil)
            self.presentViewController(image, animated: true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        profilePic.image = image
        
        let imageData = UIImagePNGRepresentation(profilePic.image!)
        let imageFile = PFFile(name: "profilePic.png", data: imageData!)
        imageFile?.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                print("success")
                var user = PFUser.currentUser()
                user!.setObject(imageFile!, forKey: "profileImage")
                
                user!.saveInBackground()
            } else {
                print(error)
            }
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        profilePic.frame = CGRectMake(0, 0, 100, 100)
        profilePic.layer.cornerRadius = profilePic.frame.height * 1.2
        profilePic.clipsToBounds = true
        
        username.text = PFUser.currentUser()?.username
        
        var user = PFUser.query()
        user?.whereKey("_id", equalTo: (PFUser.currentUser()?.objectId)!)
        user?.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
            if error == nil {
                for users in object! {
                    if users["profileImage"] != nil {
                     users["profileImage"].getDataInBackgroundWithBlock({ (data, error) -> Void in
                        if let downloadedImage = UIImage(data: data!) {
                            self.profilePic.image = downloadedImage
                        }
                        
                     })
                    }
                }
            }
        })
        var numOfFollowers:Int32?
        var numFollowing: Int32?
        var challengesAccepted = 0
        var query1 = PFQuery(className: "Followers")
        query1.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
        query1.countObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                numFollowing = object
                    self.followingCount.text = "following: \(numFollowing!-1)"
            }
        }
        var query2 = PFQuery(className: "Followers")
        query2.whereKey("following", equalTo: (PFUser.currentUser()?.objectId)!)
        query2.countObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                print(object)
                numOfFollowers = object
                    self.followersCount.text = "followers: \(numOfFollowers!-1)"
            } else {
                print(error)
            }
        }
        var query3 = PFQuery(className: "Post")
        query3.whereKey("userId", equalTo: (PFUser.currentUser()?.objectId)!)
        query3.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            if error == nil {
                if let object = object {
                    for user in object {
                        challengesAccepted++
                    }
                    self.challengesCount.text = "challenges accepted: \(challengesAccepted)"
                }
            }
        }

       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
