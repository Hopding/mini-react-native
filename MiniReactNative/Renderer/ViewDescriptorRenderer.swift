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
//            let view = createUIComponent(fromValue: descriptor)!
//            rootView.addSubview(view)
            rootView.flex.addItem(createUIComponent(fromValue: descriptor)!)
        }
    }
}
