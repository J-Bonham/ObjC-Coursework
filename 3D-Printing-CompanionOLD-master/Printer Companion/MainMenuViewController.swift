//
//  MainMenuViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/13/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connectivity check
        if Reachability.isConnectedToNetwork() == true {
            
            print("connected")
            
        } else {
            
            print("no network connection")
            
            //no connectivity alert
            let alert = UIAlertController(title: "No Network Connection", message: "Please check internet connection as some features will not work correctly without connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }

    @IBAction func unwindForSegue(segue: UIStoryboardSegue) {
    }
  
}
