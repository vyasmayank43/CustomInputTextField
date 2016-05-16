# CustomInputTextField
Customised UITextField with HintLabel, ErrorLabel, Divider and validations


## Purpose
CustomInputTextField is a class to provide Android InputLayout functionality in iOS like HintLabel, ErrorLabel.


## Supported OS & SDK Versions
Supported build target - iOS 8.0 (Xcode 7.3)


## ARC Compatibility
CustomInputTextField requires ARC.


## Installation

1. Add CustomInputTextField in your Project.
2. Drop UITextField in Storyboard or .xib and change it class to CustomInputTextField.
3. Change values of IBInspectable as per your requirement. You can change following custom properties to show hint, divider or error message.

       hintTextColor  
       hintActiveTextColor  
       errorTextColor  
       dividerColor  
       hintFontSize  
       errorFontSize  
       errorText  

4. For validation change in your ViewController make reference of textfield and in viewDidLoad write below method:
        
        textField.textValidationType = TextValidation.Empty

You can also write your own validation with following code
        
        let predicate = NSPredicate(format:"self.length > 8")  // write custom predicate as per your requirement.
        textField.customPredicate = predicate
        textField.textValidationType = TextValidation.Custom

5. To add InputAccessoryView on textFields give them tag greater than zero with increment for next textfield.


And done....


## Credits

Inspiration from [FahimF's](https://github.com/FahimF) [FloatLabelFields](https://github.com/FahimF/FloatLabelFields) project.


## Questions   
Email: vyasmayank43@gmail.com
