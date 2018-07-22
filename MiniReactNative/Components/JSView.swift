import UIKit
import JavaScriptCore

struct JSViewDescriptor {
    let type: String
    
    let x: CGFloat?
    let y: CGFloat?
    let width: CGFloat?
    let height: CGFloat?
    
    let flex: CGFloat?
    let justifyContent: String?
    let alignItems: String?
    
    let backgroundColor: String?
    let children: JSValue?
    
    init(_ jsValue: JSValue) {
        self.type = toString(jsValue, "type")!
        
        self.x = toFloat(jsValue, "x")
        self.y = toFloat(jsValue, "y")
        self.width = toFloat(jsValue, "width")
        self.height = toFloat(jsValue, "height")
        
        self.flex = toFloat(jsValue, "flex")
        self.justifyContent = toString(jsValue, "justifyContent")
        self.alignItems = toString(jsValue, "alignItems")

        self.backgroundColor = toString(jsValue, "backgroundColor")
        
        let children = jsValue.forProperty("children")!
        self.children = children.isArray ? children : nil
    }
}

func createUIView(fromValue descriptor: JSValue, ofType view: UIView = UIView()) -> UIView {
    let desc = JSViewDescriptor(descriptor)
    
    view.backgroundColor = createUIColor(from: desc.backgroundColor)

    view.flex.justifyContent(createFlexJustifyContent(from: desc.justifyContent))
    view.flex.alignItems(createFlexAlignItems(from: desc.alignItems))
    
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
