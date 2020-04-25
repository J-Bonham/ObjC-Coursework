//
//  AchViewController.swift
//  Printer Companion
//
//  Created by Jeremiah Bonham on 10/9/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Social
import Parse


class AchViewController: UIViewController {

    @IBOutlet var enthusiast: UIImageView!
    @IBOutlet var pro: UIImageView!
    @IBOutlet var home: UIImageView!
    @IBOutlet var toy: UIImageView!
    @IBOutlet var art: UIImageView!
    @IBOutlet var costume: UIImageView!
    var projectCount: Int!
    var toyCount: Int!
    var homeCount: Int!
    var artCount: Int!
    var costumeCount: Int!
    
    var projects : [PFObject] = []
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getProjects()
        
        enthusiast.alpha = 0.1
        pro.alpha = 0.1
        home.alpha = 0.1
        toy.alpha = 0.1
        art.alpha = 0.1
        costume.alpha = 0.1
        
        projectCount = 0
        toyCount = 0
        homeCount = 0
        artCount = 0
        costumeCount = 0
        
        let enthusimageView = enthusiast
        let proimageView = pro
        let homeimageView = home
        let toyimageView = toy
        let artimageView = art
        let costumeimageView = costume
    
        let enthusiastRecognizer = UITapGestureRecognizer(target:self, action:Selector("enthusiastTapped:"))
        enthusimageView.addGestureRecognizer(enthusiastRecognizer)
        
        let proRecognizer = UITapGestureRecognizer(target:self, action:Selector("proTapped:"))
        proimageView.addGestureRecognizer(proRecognizer)
        
        let homeRecognizer = UITapGestureRecognizer(target:self, action:Selector("homeTapped:"))
        homeimageView.addGestureRecognizer(homeRecognizer)
        
        let toyRecognizer = UITapGestureRecognizer(target:self, action:Selector("toyTapped:"))
        toyimageView.addGestureRecognizer(toyRecognizer)
        
        let artRecognizer = UITapGestureRecognizer(target:self, action:Selector("artTapped:"))
        artimageView.addGestureRecognizer(artRecognizer)
        
        let costumeRecognizer = UITapGestureRecognizer(target:self, action:Selector("costumeTapped:"))
        costumeimageView.addGestureRecognizer(costumeRecognizer)
        
        enthusiast.alpha = 0.1
        pro.alpha = 0.1
        home.alpha = 0.1
        toy.alpha = 0.1
        art.alpha = 0.1
        costume.alpha = 0.1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func refresh(sender: UIButton) {
    
        getProjects()
        
        projectCount = projects.count
        

        print(projectCount)
        print(toyCount)
        print(homeCount)
        print(artCount)
        print(costumeCount)
        

        if projectCount > 5 && projectCount < 25{
            enthusiast.alpha = 1.0
            
        }
        
        if projectCount > 24{
            pro.alpha = 1.0
            
        }
        
        if toyCount > 4 {
            toy.alpha = 1.0
        }
        
        if homeCount > 4 {
            home.alpha = 1.0
        }
        
        if toyCount > 4 {
            toy.alpha = 1.0
        }
        
        if costumeCount > 4 {
            costume.alpha = 1.0
        }
        
        
    }
    
    
    func enthusiastTapped(img: AnyObject){
        if enthusiast.alpha == 1.0 {
            print("testing")
            
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(enthusiast.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }

    func getProjects (){
        let query = PFQuery(className: "project")
        
        query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        print(objects)
        if error == nil {
        
        if let objects = objects {
        
        for object in objects {
        
        if object.valueForKey("type") as! String == "toy"{
                self.toyCount = self.toyCount + 1
            print(self.toyCount)
        }
        
        if object.valueForKey("type") as! String == "home"{
                self.homeCount = self.homeCount + 1
            
            print(self.homeCount)
        }
            
        if object.valueForKey("type") as! String == "costume"{
                self.costumeCount = self.costumeCount + 1
            print(self.costumeCount)
        }
            
            if object.valueForKey("type") as! String == "art"{
                self.artCount = self.artCount + 1
                print(self.artCount)
            }
            
        self.projects.append(object)
       
            }
        }
        
        } else {
        print("Error:")
        }
        
        }
        

    }
    
    
    func proTapped(img: AnyObject){
        if pro.alpha == 1.0 {
            print("pro")
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(pro.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    func homeTapped(img: AnyObject){
        if home.alpha == 1.0 {
            print("home")
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(home.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    func toyTapped(img: AnyObject){
        if toy.alpha == 1.0 {
            print("toy")
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(toy.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    func artTapped(img: AnyObject){
        if art.alpha == 1.0 {
            print("art")
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(art.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    func costumeTapped(img: AnyObject){
        if costume.alpha == 1.0 {
            print("costume")
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
                facebookSheet.addImage(costume.image)
                
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
  
}
