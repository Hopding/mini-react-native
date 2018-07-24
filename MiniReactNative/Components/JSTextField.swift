import UIKit
import JavaScriptCore

struct JSTextFieldDescriptor {
    let placeholder: String
    let textAlignment: String?
    let autocorrect: Bool
    let autocapitalize: Bool
    let onPress: (String) -> Void
    
    init(_ jsValue: JSValue) {
        self.placeholder = toString(jsValue, "placeholder") ?? ""
        self.textAlignment = toString(jsValue, "textAlignment")
        self.autocorrect = toBool(jsValue, "autocorrect") ?? false
        self.autocapitalize = toBool(jsValue, "autocapitalize") ?? false
        self.onPress = toFunc3(jsValue, "onPress")
    }
}

func createUITextField(fromValue descriptor: JSValue) -> UITextField {
    let desc = JSTextFieldDescriptor(descriptor)
    
    let textField: UITextField = createUIView(fromValue: descriptor, ofType: UITextField()) as! UITextField
    
    textField.placeholder = desc.placeholder
    textField.textAlignment = createNSTextAlignment(from: desc.textAlignment)
    textField.autocorrectionType = desc.autocorrect ? UITextAutocorrectionType.yes : UITextAutocorrectionType.no
    textField.autocapitalizationType = desc.autocapitalize ? UITextAutocapitalizationType.sentences : UITextAutocapitalizationType.none
    textField.addTargetClosure { (targetField: UITextField) in
        desc.onPress(targetField.text ?? "")
    }

    return textField
}
