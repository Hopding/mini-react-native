import UIKit
import JavaScriptCore

struct JSButtonDescriptor {
    let title: String
    let onPress: () -> Void
    
    init(_ jsValue: JSValue) {
        self.title = toString(jsValue, "title")
        self.onPress = toFunc(jsValue, "onPress")
    }
}

func createUIButton(fromValue descriptor: JSValue) -> UIButton {
    let desc = JSButtonDescriptor(descriptor)
    
    let button: UIButton = createUIView(fromValue: descriptor, ofType: UIButton()) as! UIButton 
    
    button.setTitle(desc.title, for: .normal)
    button.addTargetClosure({ _ in desc.onPress() })
    return button
}
