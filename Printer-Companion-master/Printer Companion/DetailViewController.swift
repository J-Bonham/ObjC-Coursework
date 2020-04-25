//
//  DetailViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/20/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse
import Social

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentProject : PFObject?
    var projectToShare : PFObject?
    var imagePicker: UIImagePickerController!

    @IBOutlet var changePhoto: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentTitle: UITextField!
    @IBOutlet weak var currentLength: UITextField!
    @IBOutlet weak var currentProjType: UITextField!
    @IBOutlet weak var currentTimeLength: UITextField!
    @IBOutlet weak var currentCost: UITextField!
    @IBOutlet weak var currentNotes: UITextField!
    @IBOutlet var editButton: UIButton!
    var currentUser = PFUser.currentUser()
    var likedBy : [String]!

    var currentProjectID : String!
    var anotherPhoto : String?

    let destinationPath = NSTemporaryDirectory() + "costOfTime.txt"
    let destinationPath2 = NSTemporaryDirectory() + "costOfMats.txt"
    
    var costOfMatsPassed : String!
    var costOfTimePassed : String!
    var added1 = 1.0
    var added2 = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePhoto.hidden = true
        changePhoto.enabled = false
        readMats("costOfMats.txt")
        readTime("costOfTime.txt")
        
        added1 = NSString(string: currentLength.text!).doubleValue
        added2 = NSString(string: currentTimeLength.text!).doubleValue
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let userImageFile = currentProject?.valueForKey("imageFile") as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                     if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.currentImage.image = image
                }
            }
        }
        
        currentProjectID = currentProject?.objectId
        currentTitle.text = currentProject!.valueForKey("name")! as? String
        currentLength.text = currentProject!.valueForKey("materialLength")! as? String
        currentProjType.text = currentProject!.valueForKey("type")! as? String
        currentTimeLength.text = currentProject!.valueForKey("time")! as? String
        currentCost.text = currentProject!.valueForKey("cost")! as? String
        currentNotes.text = currentProject!.valueForKey("notes")! as? String

        self.currentTitle.delegate = self
        self.currentLength.delegate = self
        self.currentProjType.delegate = self
        self.currentTimeLength.delegate = self
    }
    
    //edit
    @IBAction func edit(sender: UIButton) {
        changePhoto.hidden = false
        changePhoto.enabled = true
        let titleValueString = editButton.currentTitle!
        editButton.setTitle("SAVE", forState: UIControlState.Normal)
        
        changePhoto.hidden = false
        changePhoto.enabled = true
        
        currentTitle.enabled = true
        currentLength.enabled = true
        currentProjType.enabled = true
        currentTimeLength.enabled = true
        currentCost.enabled = true
        currentNotes.enabled = true
        
        if titleValueString == "SAVE" {
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
            
            changePhoto.hidden = true
            changePhoto.enabled = false
            
            currentTitle.enabled = false
            currentLength.enabled = false
            currentProjType.enabled = false
            currentTimeLength.enabled = false
            currentCost.enabled = false
            currentNotes.enabled = false
            
            added1 = NSString(string: currentLength.text!).doubleValue
            added2 = NSString(string: currentTimeLength.text!).doubleValue
            
            let added3 = NSString(string: costOfMatsPassed).doubleValue
            let added4 = NSString(string: costOfTimePassed).doubleValue
            let added12 = added1 * added3
            let added34 = added2 * added4
            let calcCost = added12 + added34
            let calcCostString = NSString(format: "%.2f", calcCost)
            
            let query = PFQuery(className:"project")
            query.getObjectInBackgroundWithId(currentProjectID) {
                (project: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let project = project {
                    project["name"] = self.currentTitle.text
                    
                    project["name"] = self.currentTitle.text
                    project["materialLength"] = self.currentLength.text
                    project["type"] = self.currentProjType.text
                    project["time"] = self.currentTimeLength.text
                    project["cost"] = calcCostString as String
                    project["notes"] = self.currentNotes.text
                    
                    //print("project updated")
                    
                    let imageData = UIImageJPEGRepresentation(self.currentImage.image!, 50)
                    let imageFile = PFFile(name:"image.png", data:imageData!)
                    project["imageFile"] = imageFile
                    
                    
                    project.saveInBackground()

                    let alert = UIAlertController(title: "Complete", message: "Project Updated", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
  
                }
            }
        }
    }
   
    //delete
    @IBAction func deleteProject(sender: UIButton) {
        
        let deleteAlert = UIAlertController(title: "Delete", message: "Do you really want to remove this project?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
             self.currentProject?.deleteInBackground()

            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("pop", object: nil)

        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
           
        }))
        
        presentViewController(deleteAlert, animated: true, completion: nil)
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    //share to facebook
    @IBAction func facebookButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Sharing this image from 3D Printing Companion for iOS")
            facebookSheet.addImage(currentImage.image)
            
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //share to feed
    @IBAction func shareToFeed(sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Notice", message: "Do you want to share to to the Photo Feed?.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
            let userNameText = self.currentUser!.username
            
            self.projectToShare = PFObject(className: "photoFeed")
            self.projectToShare!.setObject(self.currentTitle.text!.uppercaseString, forKey: "name")
            self.projectToShare!.setObject(userNameText!.uppercaseString, forKey: "user")
            let imageData = UIImageJPEGRepresentation(self.currentImage.image!, 40)
            let imageFile = PFFile(name:"image.png", data:imageData!)
            self.projectToShare!["imageFile"] = imageFile as PFFile
            self.projectToShare!.setObject(0, forKey: "likes")
            self.projectToShare!.setObject([], forKey: "likedBy")

            self.projectToShare!.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                
                if succeeded {
                    print("Saved")
                } else {
                    print("Error")
                    
                    let alert = UIAlertController(title: "Problem", message: "Project was not shared. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Canceled")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)

    }
    
    //pull material cost
    func readMats(fileName:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        let checkValidation = NSFileManager.defaultManager()
        //var error:NSError?
        var file:String
        
        if checkValidation.fileExistsAtPath(path) {
            
            do {
                file = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            } catch {
                file = ""
            }
            
        } else {
            file = ""
        }
        
        costOfMatsPassed = file
        return file
        
    }
    
    //pull time cost
    func readTime(fileName:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        let checkValidation = NSFileManager.defaultManager()
        var file:String
        
        if checkValidation.fileExistsAtPath(path) {
            
            do {
                file = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            } catch {
                file = ""
            }
            
        } else {
            file = ""
        }
        
        costOfTimePassed = file
        return file
        
    }
    
    //image picker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        currentImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    //take photo or open open image picker
    @IBAction func takePhoto(sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Please Choose", message: "Camera or Library?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Use Camera", style: .Default, handler: { (action: UIAlertAction!) in
            self.imagePicker =  UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Use Library", style: .Default, handler: { (action: UIAlertAction!) in
            self.imagePicker =  UIImagePickerController()
            self.imagePicker.delegate = self
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
}