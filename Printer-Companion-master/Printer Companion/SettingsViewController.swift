//
//  SettingsViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/16/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse


class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet  var deleteAll: UIButton!
    @IBOutlet var costOfTime: UITextField!
    @IBOutlet var costOfMats: UITextField!
    var currentUser = PFUser.currentUser()
    
    let destinationPath = NSTemporaryDirectory() + "costOfTime.txt"
    let destinationPath2 = NSTemporaryDirectory() + "costOfMats.txt"
    
    var error:NSError?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readMats("costOfMats.txt")
        readTime("costOfTime.txt")
        
        self.costOfTime.delegate = self
        self.costOfMats.delegate = self

        
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func loggedOut(sender: UIButton) {
        PFUser.logOut()
        
        currentUser = PFUser.currentUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                file = "1.0"
            }
            
        } else {
            file = "1.0"
        }
       
        costOfMats.text = file
        return file
        
    }
    

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
                file = "1..0"
            }
            
        } else {
            file = "1.0"
        }
        
        costOfTime.text = file
        return file
        
    }
    
    
    func writeToDocumentsFile(fileName:String,value:String) {
        let costEntered =  costOfTime.text
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        //var error:NSError?
        do {
            try costEntered!.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        }catch {
            error
        }
        
        
    }
    
    
    func writeToDocumentsFile2(fileName:String,value:String) {
        let matsEntered =  costOfMats.text
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        //var error:NSError?
        do {
            try matsEntered!.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        }catch {
            error
        }
    }
    
    
    
    @IBAction func saveAll(sender: UIButton) {
        print(costOfTime.text!)
        print(costOfMats.text!)
        
        writeToDocumentsFile("costOfTime.txt", value: costOfTime.text!)
        writeToDocumentsFile2("costOfMats.txt", value: costOfMats.text!)
    }
    

}
