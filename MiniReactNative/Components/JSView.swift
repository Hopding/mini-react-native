import UIKit
import JavaScriptCore

struct JSViewDescriptor {
    let type: String
    
    let x: CGFloat?
    let y: CGFloat?
    let width: CGFloat?
    let height: CGFloat?
    
    let flex: CGFloat?
    
    let color: String
    let children: JSValue?
    
    init(_ jsValue: JSValue) {
        self.type = toString(jsValue, "type")
        
        self.x = toFloat(jsValue, "x")
        self.y = toFloat(jsValue, "y")
        self.width = toFloat(jsValue, "width")
        self.height = toFloat(jsValue, "height")
        
        self.flex = toFloat(jsValue, "flex")
        
        self.color = toString(jsValue, "color")
        
        let children = jsValue.forProperty("children")!
        self.children = children.isArray ? children : nil
    }
}

func createUIView(fromValue descriptor: JSValue) -> UIView {
    let desc = JSViewDescriptor(descriptor)
    let view = UIView()
    view.backgroundColor = createUIColor(from: desc.color)
    
    if let flex = desc.flex {
        view.flex.grow(flex)
    }
    if let width = desc.width {
        view.flex.width(width)
    }
    if let height = desc.height {
        view.flex.height(height)
    }

    if let children = desc.children {
        for child in toArray(children) {
            view.addSubview(createUIComponent(fromValue: child)!)
        }
    }

    return view
}
