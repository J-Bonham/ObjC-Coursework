//
//  AccountViewController.swift
//  Printer Companion
//
//  Created by Jeremiah Bonham on 10/16/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse


class AccountViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var userName: UITextField!
    @IBOutlet  var emailForgot: UITextField!
    var currentUser = PFUser.currentUser()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailForgot.delegate = self

        print(currentUser)
        
        
        userName.text = currentUser!.username
        emailForgot.text = currentUser!.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func updateEmail(sender: AnyObject) {
        currentUser!.email = emailForgot.text
        currentUser!.saveInBackground()

        let alert = UIAlertController(title: "Updated", message: "Email address updated", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    
    }
    
    @IBAction func updateUsername(sender: AnyObject) {
        
        currentUser!.username = userName.text
        currentUser!.saveInBackground()
        let alert = UIAlertController(title: "Updated", message: "Username updated", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func forgot(sender: UIButton) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            let passwordInputToSend = emailForgot.text
            
            if emailForgot.text == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter an email address!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            
            } else {
                
                PFUser.requestPasswordResetForEmailInBackground(passwordInputToSend!)
            }
        }
    }
    

}
