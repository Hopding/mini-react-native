import Foundation
import JavaScriptCore
import UIKit

class JSBundleHarness {
    let jsContext: JSContext
    let rootView: UIView
    var jsPressHandler: JSValue? = nil

    init(forBundle jsBundle: String, withRootView rootView: UIView) {
        self.jsContext = JSContext()!
        self.rootView = rootView
        
        let injector = JSBundleInjector(for: jsContext)
        injector.injectGlobal(value: self.jsLog, withName: "log")
        injector.injectGlobal(value: self.render, withName: "render")

        jsContext.exceptionHandler = self.handleJSException;
        jsContext.evaluateScript(jsBundle)
    }
    
    func handleJSException(context: JSContext?, exception: JSValue?) {
        print("JS Error: \(String(describing: exception))")
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let _ = jsPressHandler?.call(withArguments: [])
    }
    
    func jsLog(input: String) {
        print(input)
    }
    
    func render(_ viewDescriptors: Array<[String: String]>) {
        rootView.subviews.forEach({ $0.removeFromSuperview() })
        var idx = 0
        for object in viewDescriptors {
            let type = object["type"]
            let color = object["color"]
            let title = object["title"]
            print(object)
            if (type == "Button") {
                let button = UIButton(frame: CGRect(x: 100, y: 100 * idx, width: 100, height: 50))
                button.backgroundColor = UIColorFrom(color)
                button.setTitle(title, for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                rootView.addSubview(button)
            }
            idx += 1
        }
    }
}
