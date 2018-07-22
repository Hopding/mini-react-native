import Foundation
import JavaScriptCore
import UIKit

class JSBundleHarness {
    let jsContext: JSContext
    let injector: JSBundleInjector
    let navigationController: UINavigationController
    var jsPressHandler: JSValue? = nil

    init(forBundle jsBundle: String, withNavigationController navigationController: UINavigationController) {
        self.jsContext = JSContext()!
        self.navigationController = navigationController
        self.injector = JSBundleInjector(for: jsContext)

        injector.injectGlobal(value: self.log, withName: "log")
        injector.injectGlobal(value: self.setTimeout, withName: "setTimeout")
        injector.injectGlobal(value: self.navigate, withName: "navigate")
        injector.injectGlobal(value: self.navigateBack, withName: "navigateBack")

        jsContext.exceptionHandler = self.handleJSException;
        jsContext.evaluateScript(jsBundle)
    }
    
    func handleJSException(context: JSContext?, exception: JSValue?) {
        print("JS Error: \(String(describing: exception! ))")
    }

    func log(input: String) {
        print(input)
    }
    
    func setTimeout(input: JSValue, timeoutMillis: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(timeoutMillis / 1000)) {
            input.call(withArguments: [])
        }
    }
    
    func navigate(viewControllerDescriptor: JSValue) {
        let jsVCHarness = JSViewControllerHarness()
        let injectionReadyRender = injector.prepForInjection(value: jsVCHarness.render)
        let _ = viewControllerDescriptor.construct(withArguments: [injectionReadyRender])
        navigationController.pushViewController(jsVCHarness.viewController, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
