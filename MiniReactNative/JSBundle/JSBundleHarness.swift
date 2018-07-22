import Foundation
import JavaScriptCore
import UIKit

class JSBundleHarness {
    let jsContext: JSContext
    let injector: JSBundleInjector
    let navigationController: UINavigationController
    var jsPressHandler: JSValue? = nil
    var orientationChangeListeners: [JSValue] = []

    init(forBundle jsBundle: String, withNavigationController navigationController: UINavigationController) {
        self.jsContext = JSContext()!
        self.navigationController = navigationController
        self.injector = JSBundleInjector(for: jsContext)

        injector.injectGlobal(value: self.log, withName: "log")
        injector.injectGlobal(value: self.setTimeout, withName: "setTimeout")
        injector.injectGlobal(value: self.navigate, withName: "navigate")
        injector.injectGlobal(value: self.navigateBack, withName: "navigateBack")
        injector.injectGlobal(value: self.screenWidth, withName: "screenWidth")
        injector.injectGlobal(value: self.screenHeight, withName: "screenHeight")
        injector.injectGlobal(value: self.addOrientationChangeListener, withName: "addOrientationChangeListener")

        jsContext.exceptionHandler = self.handleJSException;
        jsContext.evaluateScript(jsBundle)
        
        NotificationCenter.default.addObserver(
            self,
            selector:
            #selector(self.handleOrientationChange),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleOrientationChange() {
        let orientation = UIDevice.current.orientation.isPortrait ? "portrait" : "landscape"
        for listener in self.orientationChangeListeners {
            listener.call(withArguments: [orientation])
        }
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
    
    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func addOrientationChangeListener(listener: JSValue) {
        self.orientationChangeListeners.append(listener)
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
