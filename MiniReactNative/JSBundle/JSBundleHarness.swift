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
        injector.injectGlobal(value: self.foobar, withName: "foobar")
        injector.injectGlobal(value: self.buttonCallback, withName: "buttonCallback")
        
        jsContext.setObject(Foo.self, forKeyedSubscript: "Foo" as NSCopying & NSObjectProtocol)
        jsContext.setObject(Button.self, forKeyedSubscript: "Button" as NSCopying & NSObjectProtocol)

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
    
    func foobar(value: Foo) {
        print("FOO_BAR_DESC: \(value)")
    }
    
    func buttonCallback(value: Button) {
        print("BUTTON: \(value)")
        value.onPress.call(withArguments: [])
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
