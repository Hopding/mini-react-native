import UIKit
import JavaScriptCore

struct JSButtonDescriptor {
    let type: String
    
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    
    let color: String
    let title: String
    let onPress: () -> Void
    
    init(_ jsValue: JSValue) {
        self.type = toString(jsValue, "type")
        
        self.x = toInt(jsValue, "x")
        self.y = toInt(jsValue, "y")
        self.width = toInt(jsValue, "width")
        self.height = toInt(jsValue, "height")
        
        self.color = toString(jsValue, "color")
        self.title = toString(jsValue, "title")
        self.onPress = toFunc(jsValue, "onPress")
    }
}

func createUIButton(fromValue descriptor: JSValue) -> UIButton {
    let desc = JSButtonDescriptor(descriptor)
    let button = UIButton(frame: CGRect(
        x: desc.x,
        y: desc.y,
        width: desc.width,
        height: desc.height
    ))
    button.backgroundColor = createUIColor(from: desc.color)
    button.setTitle(desc.title, for: .normal)
    button.addTargetClosure({ _ in desc.onPress() })
    return button
}
