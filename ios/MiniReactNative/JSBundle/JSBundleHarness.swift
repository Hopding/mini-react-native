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
        injector.injectGlobal(value: self.makeHttpRequest, withName: "makeHttpRequest")
        injector.injectGlobal(value: self.openURL, withName: "openURL")

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
    
    func makeHttpRequest(config: JSValue) {
        let url      = config.forProperty("url").toString()!
        let method   = config.forProperty("method").toString().uppercased()
        let callback = config.forProperty("callback")
        
        if (url.isEmpty) {
            _ = callback?.call(withArguments: [[ "error": "Missing 'url' config value" ]])
            return
        }

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let decodedData = String(data: data!, encoding: String.Encoding.utf8)!
                let res: [String: Any] = [
                    "data": decodedData,
                    "statusCode": httpResponse.statusCode,
                ]
                DispatchQueue.main.async {
                    let _ = callback?.call(withArguments: [res])
                }
            }
        }).resume()
    }
    
    func openURL(link: String) {
        if let link = URL(string: link) {
            UIApplication.shared.open(link)
        } else {
            print("Invalid URL: \"\(link)\"")
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
    
    func navigate(viewControllerDescriptor: JSValue, title: JSValue) {
        let jsVCHarness = JSViewControllerHarness(withTitle: title.isString ? title.toString() : "")
        let injectionReadyRender = injector.prepForInjection(value: jsVCHarness.render)
        let vcd = viewControllerDescriptor.construct(withArguments: [injectionReadyRender])
        
        let isOrientationSensitive = viewControllerDescriptor.forProperty("orientationSensitive")
        if (isOrientationSensitive?.isBoolean)! && isOrientationSensitive?.toBool() == true {
            addOrientationChangeListener(listener: (vcd?.forProperty("rerender"))!)
        }
        
        _ = vcd?.forProperty("rerender").call(withArguments: [])
        navigationController.pushViewController(jsVCHarness.viewController, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
