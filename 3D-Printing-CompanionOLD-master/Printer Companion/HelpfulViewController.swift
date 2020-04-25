//
//  HelpfulViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/16/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit

class HelpfulViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func openThingClicked(sender: UIButton) {
        let openLink = NSURL(string : "http://www.thingiverse.com")
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func openMiniClicked(sender: UIButton) {
        let openLink = NSURL(string : "https://www.myminifactory.com")
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func openCubifyClicked(sender: UIButton) {
        let openLink = NSURL(string : "http://cubify.com")
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func openAutoDeskClicked(sender: UIButton) {
        let openLink = NSURL(string : "http://www.123dapp.com")
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func openShapewaysClicked(sender: UIButton) {
        let openLink = NSURL(string : "http://www.shapeways.com")
        UIApplication.sharedApplication().openURL(openLink!)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
