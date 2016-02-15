/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    
    @IBOutlet var userNameField: UITextField!

    @IBOutlet var passwordField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        
        if userNameField.text == "" || passwordField.text == "" {
            
            let alert = UIAlertController(title: "Error in form", message: "Please enter a username and password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func login(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
