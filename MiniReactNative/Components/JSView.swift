import UIKit
import JavaScriptCore

struct JSViewDescriptor {
    let type: String
    
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    
    let color: String
    let children: JSValue
    
    init(_ jsValue: JSValue) {
        self.type = toString(jsValue, "type")
        
        self.x = toInt(jsValue, "x")
        self.y = toInt(jsValue, "y")
        self.width = toInt(jsValue, "width")
        self.height = toInt(jsValue, "height")
        
        self.color = toString(jsValue, "color")
        self.children = jsValue.forProperty("children")!
    }
}

func createUIView(fromValue descriptor: JSValue) -> UIView {
    let desc = JSViewDescriptor(descriptor)
    let view = UIView(frame: CGRect(
        x: desc.x,
        y: desc.y,
        width: desc.width,
        height: desc.height
    ))
    view.backgroundColor = createUIColor(from: desc.color)
    
    for child in toArray(desc.children) {
        view.addSubview(createUIComponent(fromValue: child)!)
    }
    
    return view
}
