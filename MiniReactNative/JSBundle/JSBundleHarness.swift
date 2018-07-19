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

    func jsLog(input: String) {
        print(input)
    }

    func render(viewDescriptor: JSValue) {
        renderer.render(viewDescriptor)
    }
}
