import UIKit
import JavaScriptCore

class ViewDescriptorRenderer {
    let rootView: UIView
    
    init(rootView: UIView) {
        self.rootView = rootView
    }
    
    func render(_ viewDescriptors: JSValue) {
        rootView.subviews.forEach({ $0.removeFromSuperview() })
        
        for descriptor in toArray(viewDescriptors) {
            rootView.addSubview(createUIComponent(fromValue: descriptor)!)
        }
    }
}
