import UIKit
import JavaScriptCore

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainBundleUrl = Bundle.main.url(forResource:"index", withExtension: "js")

        do {
            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
            let _ = JSBundleHarness(forBundle: mainBundle, withNavigationController: self)
        } catch {
            print("Failed to load main bundle!")
        }
    }
    
}
