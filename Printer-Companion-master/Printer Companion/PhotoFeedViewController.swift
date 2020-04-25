//
//  PhotoFeedViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/22/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse

class PhotoFeedViewController: UIViewController {

    @IBOutlet  var tv2: UITableView!
    var projects : [PFObject] = []
    var allProjects : PFFile?
    var projectImages = [PFFile]()
    var indrow : Int!
    var likedCount: Int!
    var index : NSIndexPath!
    var likedBy : [String]!
    var currentUser = PFUser.currentUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tv2.reloadData()
        likedCount = 0
        likedBy = []
        likedBy.removeAll()
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tv2.registerNib(nib, forCellReuseIdentifier: "photocell")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addLike:",name:"load", object: nil)
        
        let query = PFQuery(className: "photoFeed")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        self.projects.append(object)
                        
                        self.tv2.reloadData()
                    }
                    print(self.projects)
                }
                
            } else {
                print("Error:")
            }
            
        }
        
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("You selected cell #\(indexPath.row)!")
        let currentProject = self.projects[indexPath.row]
        //likedCount = likedCount + 1

        var currentLikes = [String]()
        currentLikes = currentProject.valueForKey("likedBy") as! Array<String>
        let currentUserName = self.currentUser!.username
        
        
        
        if currentLikes.contains(currentUserName!){
            print("already there")
            //currentProject.valueForKey("likedBy")!.removeObject(currentUserName!)
            self.tv2.reloadData()
            
        } else {
            
            let userNameText = self.currentUser!.username
            likedBy.append(userNameText!)
            currentProject.setObject(likedBy.count, forKey: "likes")
            currentProject.setObject(likedBy, forKey: "likedBy")
            currentProject.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            self.likedBy.removeAll()

                if succeeded {
                
                    print("Saved")
                    self.tv2.reloadData()

                } else {
                    print("Error")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell2 = tv2.dequeueReusableCellWithIdentifier("photocell", forIndexPath: indexPath) as! CustomCell
        let userImageFile = projects[indexPath.row].valueForKeyPath("imageFile") as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell2.img.image = image
                }
            }
        }
       
        cell2.label.text = projects[indexPath.row].valueForKey("name")!.uppercaseString as String
        cell2.user.text = projects[indexPath.row].valueForKey("user")!.uppercaseString as String
        
        
        var alreadyLiked = projects[indexPath.row].valueForKeyPath("likedBy")!.count as! Int
        let likedByCount =  alreadyLiked++
        let myString = String(likedByCount)
        cell2.likedByLabel.text = myString
        indrow = indexPath.row
        cell2.likeButton.tag = indexPath.row
        let likeTouched = UITapGestureRecognizer(target:self, action:Selector("likeTouched:"))
        cell2.likeButton.addGestureRecognizer(likeTouched)
        return cell2
    }

    
    func likeTouched(img: AnyObject){
        print("test")
    
        }
    
    @IBAction func home(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


