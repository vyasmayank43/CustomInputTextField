//
//  ViewController.swift
//  Demo
//
//  Created by Mayank Vyas on 16/05/16.
//  Copyright © 2016 MoonShine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBProperties
    
    @IBOutlet weak var userEmailField: CustomInputTextField!
    @IBOutlet weak var passwordField: CustomInputTextField!
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailField.textValidationType = TextValidation.Email
        
        let passwordPredicate = NSPredicate(format:"self.length > 8")
        passwordField.customPredicate = passwordPredicate
        passwordField.textValidationType = TextValidation.Custom
    }
    
    
    // MARK: - IBAction
    @IBAction func goBtnAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var check: Bool = true
        
        check = userEmailField.validateText()
        check = passwordField.validateText()
        
        
        if check == true {
            
            let controller: UIAlertController = UIAlertController(title: "Success", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            controller.addAction(action)
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        (textField as! CustomInputTextField).hideValidation()
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        (textField as! CustomInputTextField).validateText()
        
        textField.resignFirstResponder()
        
        return true
    }
}