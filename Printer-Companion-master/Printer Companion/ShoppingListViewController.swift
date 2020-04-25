//
//  ShoppingListViewController.swift
//  3D Printing Companion
//
//  Created by Jeremiah Bonham on 9/16/15.
//  Copyright (c) 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var shoppingList: UITextView!
    
    let destinationPath = NSTemporaryDirectory() + "shoplist.txt"
    var error:NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromDocumentsFile("shoplist.txt")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editShoppingList(sender: UIButton) {

        let shoppingListEntered =  shoppingList.text
        //print(shoppingListEntered)
        
        let titleValueString = editButton.currentTitle!
        editButton.setTitle("SAVE", forState: UIControlState.Normal)
        shoppingList.editable = true;
  
        if titleValueString == "SAVE" {
            shoppingList.editable = false;
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
            
            writeToDocumentsFile("shoplist.txt",value:shoppingListEntered)
            
        }
        
    }
    

    func writeToDocumentsFile(fileName:String,value:String) {
        let shoppingListEntered =  shoppingList.text
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)

        do {
            try shoppingListEntered.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        }catch {
            error
        }
    }
    
    func readFromDocumentsFile(fileName:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        let checkValidation = NSFileManager.defaultManager()
        var file:String
        
        if checkValidation.fileExistsAtPath(path) {
            
            do {
                file = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            } catch {
                file = "Use this area to keep a list of needed items"
            }
            
        } else {
            file = "Use this area to keep a list of needed items"
        }
        print(file)
        shoppingList.text = file
        return file
        
    }

}
