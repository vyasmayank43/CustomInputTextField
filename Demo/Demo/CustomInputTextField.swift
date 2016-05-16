//
//  CustomInputTextField.swift
//  Demo
//
//  Created by Mayank Vyas on 16/05/16.
//  Copyright © 2016 MoonShine. All rights reserved.
//

import UIKit

public enum TextValidation: NSInteger {
    case None
    case Empty
    case Email
    case Custom
}

@IBDesignable class CustomInputTextField: UITextField {
    
    // MARK: - Variables
    
    var hintLabel: UILabel! = UILabel()
    var hintLabelTopConst: NSLayoutConstraint!
    
    var errorLabel: UILabel! = UILabel()
    var dividerView: UIView! = UIView()
    
    var textValidationType: TextValidation = TextValidation.None
    var customPredicate: NSPredicate = NSPredicate(format: "self.length > 0")
    
    
    // MARK: - Custom IBInspectable
    
    @IBInspectable var hintTextColor: UIColor = UIColor.grayColor() {
        didSet {
            if !isFirstResponder() {
                hintLabel.textColor = hintTextColor
            }
        }
    }
    
    @IBInspectable var hintActiveTextColor: UIColor = UIColor.grayColor() {
        didSet {
            if isFirstResponder() {
                hintLabel.textColor = hintActiveTextColor
            }
        }
    }
    
    @IBInspectable var errorTextColor: UIColor = UIColor.grayColor() {
        didSet {
            if !isFirstResponder() {
                errorLabel.textColor = errorTextColor
            }
        }
    }
    
    @IBInspectable var dividerColor: UIColor = UIColor.grayColor() {
        didSet {
            if !isFirstResponder() {
                dividerView.backgroundColor = dividerColor
            }
        }
    }
    
    @IBInspectable var hintFontSize: CGFloat = 11.0 {
        didSet {
            hintLabel.font = UIFont(name: (self.font?.fontName)!, size: hintFontSize)
        }
    }
    
    @IBInspectable var errorFontSize: CGFloat = 9.0  {
        didSet {
            errorLabel.font = UIFont(name: (self.font?.fontName)!, size: errorFontSize)
        }
    }
    
    @IBInspectable var errorText: String = ""  {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    
    // MARK:- Overrides
    
    //    #if !TARGET_INTERFACE_BUILDER
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setupCustomView()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.setupCustomView()
    }
    
    private func setupCustomView() {
        
        if self.tag != 0 {
            
            let titleFont: UIFont = UIFont(name: (self.font?.fontName)!, size: 16)!
            
            let activeAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)]
            
            let keyBoardToolBar: UIToolbar = UIToolbar (frame: CGRectMake(0, 0, self.frame.size.width, 44))
            keyBoardToolBar.tintColor = UIColor (red: 0.26, green: 0.77, blue: 0.43, alpha: 1.0)
            
            let prevBarBtn: UIBarButtonItem = UIBarButtonItem (title: "  Prev", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.prevBarBtnAction(_:)))
            prevBarBtn.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
            
            let nextBarBtn: UIBarButtonItem = UIBarButtonItem (title: "  Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.nextBarBtnAction(_:)))
            nextBarBtn.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
            
            let flexibleSpaceBtn: UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            
            let doneBtn: UIBarButtonItem = UIBarButtonItem (title: "  Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.doneBarBtnAction(_:)))
            doneBtn.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
            
            let itemArray = [prevBarBtn, nextBarBtn, flexibleSpaceBtn, doneBtn]
            
            keyBoardToolBar.setItems(itemArray, animated: true)
            
            self.inputAccessoryView = keyBoardToolBar
        }
        
        hintLabel.alpha = 0.0
        hintLabel.textAlignment = NSTextAlignment.Left
        hintLabel.backgroundColor = UIColor.clearColor()
        hintLabel.textColor = hintTextColor
        hintLabel.text = self.placeholder
        self.addSubview(hintLabel)
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hintLabelTopConst = NSLayoutConstraint(item: hintLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([
            hintLabelTopConst,
            
            NSLayoutConstraint(item: hintLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: hintLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0),
            
            ])
        
        
        dividerView.alpha = 1.0
        self.addSubview(dividerView)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            
            NSLayoutConstraint(item: dividerView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: dividerView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: dividerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 1.0)
            
            ])
        
        
        errorLabel.alpha = 0.0
        errorLabel.textAlignment = NSTextAlignment.Right
        errorLabel.backgroundColor = UIColor.clearColor()
        errorLabel.textColor = errorTextColor
        self.addSubview(errorLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            
            NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: dividerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 2.0),
            
            NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0),
            
            ])
    }
    
    override var placeholder: String? {
        didSet {
            hintLabel.text = self.placeholder
        }
    }
    
    override var font: UIFont? {
        didSet {
            hintLabel.font = UIFont(name: (font?.fontName)!, size: hintFontSize)
        }
    }
    //    #endif
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let isResp = self.isFirstResponder()
        
        if isResp && self.text!.isEmpty == false {
            hintLabel.textColor = hintActiveTextColor
        } else {
            hintLabel.textColor = hintTextColor
        }
        
        // Should we show or hide the title label?
        if self.text!.isEmpty == false {
            // Hide
            self.showHintLabel()
        } else {
            // Show
            self.hideHintLabel()
        }
        
        if let toolbar: UIToolbar = self.inputAccessoryView as? UIToolbar {
            
            let titleFont: UIFont = UIFont(name: (self.font?.fontName)!, size: 16)!
            
            let activeAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)]
            
            let inactiveAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor.lightGrayColor()]
            
            let prevBarBtn: UIBarButtonItem = toolbar.items![0]
            let nextBarBtn: UIBarButtonItem = toolbar.items![1]
            
            let prevTextField = self.superview?.viewWithTag(self.tag - 1)
            
            if (prevTextField is UITextField){
                prevBarBtn.enabled = true
                prevBarBtn.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
            }
            else {
                prevBarBtn.enabled = false
                prevBarBtn.setTitleTextAttributes(inactiveAttrs, forState: UIControlState.Normal)
            }
            
            let nextTextField = self.superview?.viewWithTag(self.tag + 1)
            
            if (nextTextField is UITextField){
                nextBarBtn.enabled = true
                nextBarBtn.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
            }
            else {
                nextBarBtn.enabled = false
                nextBarBtn.setTitleTextAttributes(inactiveAttrs, forState: UIControlState.Normal)
            }
        }
    }
    
    override func textRectForBounds(bounds:CGRect) -> CGRect {
        var r = super.textRectForBounds(bounds)
        
        r.origin.x = r.origin.x + 5
        r.size.width = r.size.width - 10
        
        return r
    }
    
    override func editingRectForBounds(bounds:CGRect) -> CGRect {
        var r = super.editingRectForBounds(bounds)
        
        r.origin.x = r.origin.x + 5
        r.size.width = r.size.width - 10
        
        return r
    }
    
    
    // MARK: Private Methods
    
    private func showHintLabel() {
        
        hintLabelTopConst.constant = 0.0
        self.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.3) {
            self.layoutIfNeeded()
            self.hintLabel.alpha = 1.0
        }
    }
    
    private func hideHintLabel() {
        
        hintLabelTopConst.constant = self.hintLabel.font.lineHeight + 5
        self.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.3) {
            self.layoutIfNeeded()
            self.hintLabel.alpha = 0.0
        }
    }
    
    private func showErrorLabel() {
        
        UIView.animateWithDuration(0.3) {
            self.errorLabel.alpha = 1.0
        }
    }
    
    private func hideErrorLabel() {
        
        UIView.animateWithDuration(0.3) {
            self.errorLabel.alpha = 0.0
        }
    }
    
    
    // MARK: - IBActions
    
    func prevBarBtnAction (sender: UIBarButtonItem) {
        
        self.validateText()
        
        let titleFont: UIFont = UIFont(name: (self.font?.fontName)!, size: 16)!
        
        let activeAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)]
        
        let inactiveAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor.lightGrayColor()]
        
        
        let prevTextField = self.superview?.viewWithTag(self.tag - 1)
        
        if (prevTextField is UITextField){
            prevTextField?.becomeFirstResponder()
            sender.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
        }
        else {
            sender.enabled = false
            sender.setTitleTextAttributes(inactiveAttrs, forState: UIControlState.Normal)
        }
    }
    
    func nextBarBtnAction (sender: UIBarButtonItem) {
        
        self.validateText()
        
        let titleFont: UIFont = UIFont(name: (self.font?.fontName)!, size: 16)!
        
        let activeAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)]
        
        let inactiveAttrs = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : UIColor.lightGrayColor()]
        
        let nextTextField = self.superview?.viewWithTag(self.tag + 1)
        
        if (nextTextField is UITextField){
            nextTextField?.becomeFirstResponder()
            sender.setTitleTextAttributes(activeAttrs, forState: UIControlState.Normal)
        }
        else {
            sender.enabled = false
            sender.setTitleTextAttributes(inactiveAttrs, forState: UIControlState.Normal)
        }
    }
    
    func doneBarBtnAction (sender: UIBarButtonItem) {
        if let scrollView: UIScrollView = self.superview?.superview as? UIScrollView {
            scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, 0), animated: true)
        }
        
        self.resignFirstResponder()
        
        self.validateText()
    }
    
    func validateText() -> Bool {
        
        switch textValidationType {
            
        case .Empty:
            let result = customPredicate.evaluateWithObject(self.text)
            
            if result == false {
                self.showErrorLabel()
            }
            else {
                self.hideErrorLabel()
            }
            
            return result
            
        case TextValidation.Email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluateWithObject(self.text)
            
            if result == false {
                self.showErrorLabel()
            }
            else {
                self.hideErrorLabel()
            }
            
            return result
            
        case .Custom:
            let result = customPredicate.evaluateWithObject(self.text)
            
            if result == false {
                self.showErrorLabel()
            }
            else {
                self.hideErrorLabel()
            }
            
            return result
            
            
        default:
            return true
        }
    }
    
    func hideValidation() {
        self.hideErrorLabel()
    }
    
}

