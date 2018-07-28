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
    let flexDirection: String?
    let flexWrap: String?
    
    let backgroundColor: String?
    let borderColor: String?
    let borderWidth: CGFloat
    let borderRadius: CGFloat
    
    let padding: CGFloat
    let paddingTop: CGFloat
    let paddingBottom: CGFloat
    let paddingLeft: CGFloat
    let paddingRight: CGFloat
    
    let margin: CGFloat
    let marginTop: CGFloat
    let marginBottom: CGFloat
    let marginLeft: CGFloat
    let marginRight: CGFloat
    
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
        self.flexDirection = toString(jsValue, "flexDirection")
        self.flexWrap = toString(jsValue, "flexWrap")
        
        self.backgroundColor = toString(jsValue, "backgroundColor")
        self.borderColor = toString(jsValue, "borderColor")
        self.borderWidth = toFloat(jsValue, "borderWidth") ?? 0
        self.borderRadius = toFloat(jsValue, "borderRadius") ?? 0
        
        self.padding = toFloat(jsValue, "padding") ?? 0
        self.paddingTop = toFloat(jsValue, "paddingTop") ?? 0
        self.paddingBottom = toFloat(jsValue, "paddingBottom") ?? 0
        self.paddingLeft = toFloat(jsValue, "paddingLeft") ?? 0
        self.paddingRight = toFloat(jsValue, "paddingRight") ?? 0
        
        self.margin = toFloat(jsValue, "margin") ?? 0
        self.marginTop = toFloat(jsValue, "marginTop") ?? 0
        self.marginBottom = toFloat(jsValue, "marginBottom") ?? 0
        self.marginLeft = toFloat(jsValue, "marginLeft") ?? 0
        self.marginRight = toFloat(jsValue, "marginRight") ?? 0

        let children = jsValue.forProperty("children")!
        self.children = children.isArray ? children : nil
    }
}

func createUIView(fromValue descriptor: JSValue, ofType view: UIView = UIView()) -> UIView {
    let desc = JSViewDescriptor(descriptor)
    
    view.backgroundColor = createUIColor(from: desc.backgroundColor)
    view.layer.borderColor = createUIColor(from: desc.borderColor).cgColor
    view.layer.borderWidth = desc.borderWidth
    view.layer.cornerRadius = desc.borderRadius
    
    view.flex.justifyContent(createFlexJustifyContent(from: desc.justifyContent))
    view.flex.alignItems(createFlexAlignItems(from: desc.alignItems))
    view.flex.direction(createFlexDirection(from: desc.flexDirection))
    view.flex.wrap(createFlexWrap(from: desc.flexWrap))
    
    view.flex.padding(desc.padding)
    view.flex.paddingTop(desc.paddingTop)
    view.flex.paddingBottom(desc.paddingBottom)
    view.flex.paddingLeft(desc.paddingLeft)
    view.flex.paddingRight(desc.paddingRight)

    view.flex.margin(desc.margin)
    
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
