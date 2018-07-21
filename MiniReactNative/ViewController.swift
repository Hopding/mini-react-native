import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexTest = RootFlexView()
        self.view.backgroundColor = UIColor.red
//        self.view = flexTest
        self.view.addSubview(flexTest)

//        let mainBundleUrl = Bundle.main.url(forResource:"main", withExtension: "js")
//
//        do {
//            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
//            let harness = JSBundleHarness(forBundle: mainBundle, withRootView: self.view)
//        } catch {
//            print("Failed to load main bundle!")
//        }
    }

}

