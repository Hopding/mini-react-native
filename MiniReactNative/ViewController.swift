import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x = FlexRoot()
        
        self.view.addSubview(x)

        let mainBundleUrl = Bundle.main.url(forResource:"main", withExtension: "js")

        do {
            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
            let harness = JSBundleHarness(forBundle: mainBundle, withRootView: x)
        } catch {
            print("Failed to load main bundle!")
        }
    }

}

