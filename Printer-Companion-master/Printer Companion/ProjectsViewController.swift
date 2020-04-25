//
//  ProjectsViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/16/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit

import Parse


class ProjectsViewController: UIViewController {

    @IBOutlet  var tv: UITableView!
    var projects : [PFObject] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pop:",name:"pop", object: nil)

        
        //pull from parse
        let query = PFQuery(className: "project")
       
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            self.projects.append(object)
                            self.tv.reloadData()
                        }
                    }
                    
                } else {
                    print("Error:")
                    let alert = UIAlertController(title: "Problem", message: "There was an error connecting to your projects, please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
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
        return self.projects.count
    }

    func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCellWithIdentifier("projectcell", forIndexPath: indexPath) as UITableViewCell
        let currentProject = self.projects[indexPath.row]
        //print (currentProject)
        cell.textLabel!.text = currentProject.valueForKey("name")! as? String
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let currentProject = self.projects[indexPath.row]
            currentProject.deleteInBackground()
            self.tv.reloadData()
            dismissViewControllerAnimated(true, completion: nil)

        }
    }
    
    func reloadTable (){
         self.tv.reloadData()
    }
    
    
    @IBAction func pop(sender: UIButton) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func returnHome(notification: NSNotification){
        //load data here
        dismissViewControllerAnimated(true, completion: nil)
    }

    func loadList(notification: NSNotification){
        self.tv.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondScene = segue.destinationViewController as! DetailViewController
        if let indexPath = self.tv.indexPathForSelectedRow {
            let selectedProject = self.projects[indexPath.row]
           secondScene.currentProject = selectedProject
        }else{
            
        }
    }
}
