import Foundation
import UIKit
import JavaScriptCore

//struct ViewDescriptor: Codable {
//    let type: String
//    let color: String
//    let title: String
//    let children: [ViewDescriptor]?
//}

//struct ViewDescriptor: Codable {
//    let type: String
//    let color: String
//    let title: String
//    let onPress: JSValue?
//    let children: [ViewDescriptor]?
//
//    init(type: JSValue, color: JSValue, title: JSValue, onPress: JSValue, children: JSValue) {
//        self.type = type.toString()!
//        self.color = color.toString()!
//        self.title = title.toString()!
//        self.onPress = onPress
//        self.children = []
//        if let tc = children.toArray()
//        self.children =
//    }
//}


import UIKit

typealias UIButtonTargetClosure = (UIButton) -> ()

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(_ closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

class ViewDescriptorRenderer {
    let rootView: UIView
    
    init(rootView: UIView) {
        self.rootView = rootView
    }
    
    func pressHandlerFor(_ value: JSValue) -> () -> Void {
        return { value.call(withArguments: []) }
    }
    
    func render(_ viewDescriptors: JSValue) {
        print("SIZE: \(viewDescriptors.forProperty("length"))")

        rootView.subviews.forEach({ $0.removeFromSuperview() })
        var index = 0
        let size = viewDescriptors.forProperty("length").toInt32()
//        for descriptor in viewDescriptors.toArray() as! [JSValue]  {
//        for descriptor in viewDescriptors.atIndex(size) {
        while index < size {
            let descriptor = viewDescriptors.atIndex(index)!
            if (descriptor.forProperty("type").toString() == "Button") {
                let button = UIButton(frame: CGRect(x: 100, y: 100 * index, width: 100, height: 50))
                button.backgroundColor = UIColorFrom(descriptor.forProperty("color").toString())
                button.setTitle(descriptor.forProperty("title").toString(), for: .normal)
//                button.addTarget(self, action: #selector(pressHandlerFor(descriptor.forProperty("onPress"))), for: .touchUpInside)
                
                button.addTargetClosure({ _ in descriptor.forProperty("onPress").call(withArguments: []) })
                
                if let children = descriptor.forProperty("children") {
                    let vdr = ViewDescriptorRenderer(rootView: button)
                    vdr.render(children)
                }
                
                rootView.addSubview(button)
            }
            index += 1
        }
    }
    
//    func render(_ viewDescriptors: [ViewDescriptor]) {
//        rootView.subviews.forEach({ $0.removeFromSuperview() })
//        for (index, descriptor) in viewDescriptors.enumerated() {
//            if (descriptor.type == "Button") {
//                let button = UIButton(frame: CGRect(x: 100, y: 100 * index, width: 100, height: 50))
//                button.backgroundColor = UIColorFrom(descriptor.color)
//                button.setTitle(descriptor.title, for: .normal)
//                button.addTarget(self, action: #selector(pressHandlerFor(descriptor.)), for: .touchUpInside)
//
//                if let children = descriptor.children {
//                    let vdr = ViewDescriptorRenderer(rootView: button)
//                    vdr.render(children)
//                }
//
//                rootView.addSubview(button)
//            }
//        }
//    }
}
