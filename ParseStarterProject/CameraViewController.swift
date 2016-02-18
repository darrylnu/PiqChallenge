//
//  CameraViewController.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/16/16.
//  Copyright © 2016 Nunnotha. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet var challengePicker: UIPickerView!
    
    var challengeSource = ["Choose Challenge", "#randomKiss", "#iceBucket", "#boogerMunch"]
    var chosenChallenge: String?
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    @IBOutlet var comment: UITextField!
    
    @IBOutlet var imagePlaceholder: UIImageView!
    
    @IBAction func postImage(sender: AnyObject) {
        
        if imagePlaceholder.image != UIImage(named: "1455683886_camera.png") {
            
            //            print(imagePlaceholder)
            //            print(imagePlaceholder.image)
            
            
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            let imageData = UIImagePNGRepresentation(imagePlaceholder.image!)
            let imageFile = PFFile(name: "image.png", data: imageData!)
            
            var post = PFObject(className: "Post")
            post["userId"] = PFUser.currentUser()?.objectId
            post["imageComment"] = chosenChallenge
            post["imageFile"] = imageFile
            
            post.saveInBackgroundWithBlock { (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    print("success")
                    self.imagePlaceholder.image = UIImage(named: "1455683886_camera.png")
                    self.postedAlerter("Post Successful", message: "Challenge Accepted!", addAction: "Cool")
                    
                    
                } else {
                    self.postedAlerter("Post Unsuccessful", message: "Please try again later", addAction: "Ok")
                }
            }
        } else {
            postedAlerter("Image Not Found", message: "Please choose an image to upload", addAction: "Ok, my bad")
        }
        
        
    }
    @IBAction func chooseImage(sender: AnyObject) {
        
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
        imagePlaceholder.image = image
    }
    
    func postedAlerter (title:String, message: String, addAction: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.view.tintColor = UIColor.redColor()
        alert.addAction(UIAlertAction(title: addAction, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return challengeSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return challengeSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenChallenge = challengeSource[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengePicker.delegate = self
        self.challengePicker.dataSource = self
        
        
        navigationItem.hidesBackButton = true
        
        
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
