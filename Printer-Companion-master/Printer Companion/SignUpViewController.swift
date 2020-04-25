//
//  SignUpViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/22/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet  var usernameSU: UITextField!
    @IBOutlet  var passwordSU: UITextField!
    @IBOutlet  var emailSU: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.usernameSU.delegate = self
        self.passwordSU.delegate = self
        self.emailSU.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func logIn(sender: UIButton) {

        //connectivity check
        if Reachability.isConnectedToNetwork() == true {
        
        let usernameSUentered = usernameSU.text
        let passwordSUentered = passwordSU.text
        let emailSUentered = emailSU.text
        
        //validation check
        if usernameSU.text == "" || passwordSU.text == "" || emailSU.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter a username, pasword, and email address!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let user = PFUser()
        user.username = usernameSUentered
        user.password = passwordSUentered
        user.email = emailSUentered
        
        //sign in
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            
            if let error = error {
                error.userInfo["error"] as? NSString

                } else {

                //sign up confirmation
                let alert = UIAlertController(title: "Thank You", message: "Now Return Home to Log In", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                        }
                    }
            
            } else {
            
            //connectivity failure
            let alert = UIAlertController(title: "Problem", message: "Please check internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            }
        }
    
    //close keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}
