import UIKit
import JavaScriptCore

class JSViewControllerHarness {
    let viewController: UIViewController = UIViewController()
    let rootView: UIView
    
    init() {
        self.rootView = FlexRootView()
        self.viewController.view.addSubview(rootView)
    }
    
    func render(_ viewDescriptor: JSValue) {
        rootView.subviews.forEach({ $0.removeFromSuperview() })
        rootView.flex.addItem(createUIComponent(fromValue: viewDescriptor)!)
    }
}
