//
//  LogInViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/22/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet  var username: UITextField!
    @IBOutlet  var password: UITextField!
    
    var usernameInput : String!
    var passwordInput : String!
    var currentUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //tap that closes keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //Removes Text from fields after login
        username.text = ""
        password.text = ""
        
        self.username.delegate = self
        self.password.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Button(sender: AnyObject) {
        
        usernameInput = username.text
        passwordInput = password.text

        //connectivity check
        if Reachability.isConnectedToNetwork() == true {
            
            if usernameInput == "" || passwordInput == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter a username and pasword!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                
                PFUser.logInWithUsernameInBackground(usernameInput, password:passwordInput) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        
                        // clears username and password from fields
                        self.username.text = ""
                        self.password.text = ""
                        self.performSegueWithIdentifier("LogIn", sender: nil)
                        //print("Logged In")
                        
                    } else {
                        
                        //validation alert
                        let alert = UIAlertController(title: "Error", message: "Please enter a valid username and pasword!", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        //print("failed")
                        
                    }
                }
            }

        } else {
            
            //alert for no connectivity
            let alert = UIAlertController(title: "Problem", message: "Please check internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func LogOut(segue: UIStoryboardSegue) {
        
    }
    
}
