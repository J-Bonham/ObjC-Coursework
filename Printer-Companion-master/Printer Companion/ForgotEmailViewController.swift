//
//  ForgotEmailViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/22/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse

class ForgotEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet  var emailForgot: UITextField!
    var users : [PFObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.emailForgot.delegate = self
        

        
        
        //pull from parse
//        let query = PFQuery(className: "User").valueForKey("email")
//        query!.findObjectsInBackgroundWithBlock {
//            
//            
//            (objects: [PFObject]?, error: NSError?) -> Void in
//            
//            if error == nil {
//                
//                if let objects = objects {
//                    
//                    for object in objects {
//                        
//                        self.users.append(object)
//                    }
//                }
//                
//            } else {
//                print("Error:")
//                
//            }
//            
//        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func forgot(sender: UIButton) {
        
        //print(users)
        
        //connectivity check
        if Reachability.isConnectedToNetwork() == true {
        
        let passwordInputToSend = emailForgot.text
        

            
            
            
            
        if emailForgot.text == "" {
            
            //validation alert
            let alert = UIAlertController(title: "Error", message: "Please enter an email address!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {

            //checking to see if email address exists in Users
            let query = PFUser.query()
            
            query!.whereKey("email", equalTo:passwordInputToSend!)
            query!.countObjectsInBackgroundWithBlock {
                (count: Int32, error: NSError?) -> Void in
                if count > 0 {
                    
                    PFUser.requestPasswordResetForEmailInBackground(passwordInputToSend!)
                    
                    //confirmation alert
                    let alert = UIAlertController(title: "Notice", message: "Please check your email for instructions on resetting your password", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    print("\(count)")
                } else {
                    
                    let alert = UIAlertController(title: "Email address not found", message: "Please check entered email", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)

                    }
                }
            }
            
        } else {
            
            //connectivity alert
            let alert = UIAlertController(title: "Problem", message: "Please check internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
            
    }

    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

