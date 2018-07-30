import UIKit
import JavaScriptCore

// The JS bundle can be:
//   * (.Bundler) loaded via HTTP from the bundling server during development
//   * (.Assets)  read from the app's assets for production builds
let jsBundleSource = JSBundleSource.Assets

class NavigationController: UINavigationController {
    
    var harness: JSBundleHarness?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        loadAndRunJSBundle()
    }
    
    func loadAndRunJSBundle() {
        if (self.viewControllers.count > 0) {
            self.viewControllers.removeAll()
        }
        loadJSBundle(fromSource: jsBundleSource, then: { jsBundle in
            self.harness = JSBundleHarness(forBundle: jsBundle, withNavigationController: self)
        })
    }
    
    override var canBecomeFirstResponder: Bool {
        get { return true }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake && jsBundleSource == .Bundler {
            loadAndRunJSBundle()
        }
    }

}
