//
//  AddProjectViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/16/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import MobileCoreServices
import  AVFoundation
import Parse

class AddProjectViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var saveButton : UIButton!
    var imagePicker: UIImagePickerController!
    var boxView = UIView()
    var currentUser = PFUser.currentUser()
    @IBOutlet var nameInput : UITextField!
    @IBOutlet var matLengthInput : UITextField!
    @IBOutlet var projTypeInput : UITextField!
    @IBOutlet var timeInput : UITextField!
    @IBOutlet var costInput : UITextField!
    @IBOutlet var notesInput : UITextField!
    
    let destinationPath = NSTemporaryDirectory() + "costOfTime.txt"
    let destinationPath2 = NSTemporaryDirectory() + "costOfMats.txt"
    
    var costOfMatsPassed : String!
    var costOfTimePassed : String!

     var nameInputToSave : String!
     var matLengthInputToSave : String!
     var projTypeInputToSave : String!
     var timeInputToSave : String!
     var costInputToSave : String!
     var notesInputToSave : String!
    
    var added1 = 1.0
    var added2 = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        readMats("costOfMats.txt")
        readTime("costOfTime.txt")
        
        added1 = NSString(string: matLengthInput.text!).doubleValue
        added2 = NSString(string: timeInput.text!).doubleValue
        
        self.nameInput.delegate = self
        self.matLengthInput.delegate = self
        self.projTypeInput.delegate = self
        self.timeInput.delegate = self
        self.costInput.delegate = self
        self.notesInput.delegate = self
    
    }
    
    //save to parse
    @IBAction func saveProject(sender: UIButton) {
        
        if nameInput.text == "" || imageView.image == nil{
           
            let alert = UIAlertController(title: "Problem", message: "Project must contain at least an Image and Name", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            added1 = NSString(string: matLengthInput.text!).doubleValue
            added2 = NSString(string: timeInput.text!).doubleValue
            
            let added3 = NSString(string: costOfMatsPassed).doubleValue
            let added4 = NSString(string: costOfTimePassed).doubleValue
            let added12 = added1 * added2
            let added34 = added3 * added4
            let calcCost = added12 + added34
            let calcCostString = NSString(format: "%.2f", calcCost)
            
            self.DismissKeyboard()
            self.addSavingPhotoView()
            saveButton.enabled = false
            nameInputToSave = nameInput.text
            matLengthInputToSave = matLengthInput.text
            projTypeInputToSave = projTypeInput.text
            timeInputToSave = timeInput.text
            costInputToSave = calcCostString as String
            notesInputToSave = notesInput.text

        
        let project = PFObject(className: "project")

        let imageData = UIImageJPEGRepresentation(imageView.image!, 50)
        let imageFile = PFFile(name:"image.png", data:imageData!)
        project.ACL = PFACL(user: currentUser!)
        project["imageName"] = nameInput.text
        project["imageFile"] = imageFile
        project.setObject(nameInputToSave, forKey: "name")
        project.setObject(costInputToSave, forKey: "cost")
        project.setObject(matLengthInputToSave, forKey: "materialLength")
        project.setObject(notesInputToSave, forKey: "notes")
        project.setObject("TODO", forKey: "pic")
        project.setObject(timeInputToSave, forKey: "time")
        project.setObject(projTypeInputToSave, forKey: "type")
       
        project.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                
                if succeeded {
                    self.stopSpinner()
                    print("Saved")
                } else {
                    print("Error")
                }
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        }
    
    }
    
    //spinner
    func addSavingPhotoView() {
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.whiteColor()
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.grayColor()
        textLabel.text = "Saving"
        
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }

    
    func stopSpinner() {
        //When button is pressed it removes the boxView from screen
        boxView.removeFromSuperview()
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
    

    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        costOfTimePassed = file
        return file
        
    }

    
    
}
