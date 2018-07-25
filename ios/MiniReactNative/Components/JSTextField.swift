import UIKit
import JavaScriptCore

struct JSTextFieldDescriptor {
    let placeholder: String
    let textAlignment: String?
    let autocorrect: Bool
    let autocapitalize: Bool
    let onChangeText: (String) -> Void
    
    init(_ jsValue: JSValue) {
        self.placeholder = toString(jsValue, "placeholder") ?? ""
        self.textAlignment = toString(jsValue, "textAlignment")
        self.autocorrect = toBool(jsValue, "autocorrect") ?? false
        self.autocapitalize = toBool(jsValue, "autocapitalize") ?? false
        self.onChangeText = toFunc3(jsValue, "onChangeText")
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
        desc.onChangeText(targetField.text ?? "")
    }

    return textField
}
