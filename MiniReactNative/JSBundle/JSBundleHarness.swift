import Foundation
import JavaScriptCore
import UIKit

class JSBundleHarness {
    let jsContext: JSContext
    let rootView: UIView
    let renderer: ViewDescriptorRenderer
    var jsPressHandler: JSValue? = nil

    init(forBundle jsBundle: String, withRootView rootView: UIView) {
        self.jsContext = JSContext()!
        self.rootView = rootView
        self.renderer = ViewDescriptorRenderer(rootView: rootView)

        let injector = JSBundleInjector(for: jsContext)
        injector.injectGlobal(value: self.jsLog, withName: "log")
        injector.injectGlobal(value: self.render, withName: "render")

        jsContext.exceptionHandler = self.handleJSException;
        jsContext.evaluateScript(jsBundle)
    }
    
    func handleJSException(context: JSContext?, exception: JSValue?) {
        print("JS Error: \(String(describing: exception! ))")
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let _ = jsPressHandler?.call(withArguments: [])
    }
    
    func jsLog(input: String) {
        print(input)
    }
    
    func render(viewDescriptorJson: String) {
        let data    = viewDescriptorJson.data(using: .utf8)
        let decoder = JSONDecoder()
        do {
            let viewDescriptor = try decoder.decode(Array<ViewDescriptor>.self, from: data!)
            self.renderer.render(viewDescriptor)
        } catch {
            print("Failed to deserialize JSON!")
        }
    }
}