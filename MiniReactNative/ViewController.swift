import UIKit
import JavaScriptCore

class Foo: UIViewController {
    override func viewDidLoad() {
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 250, height: 250))
        view.backgroundColor = UIColor.yellow
        self.view.addSubview(view)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexRoot = FlexRootView()
        
        self.view.addSubview(flexRoot)
        
        let newViewController = Foo()
        print(self.navigationController)
        self.navigationController?.pushViewController(newViewController, animated: true)

//        let mainBundleUrl = Bundle.main.url(forResource:"main", withExtension: "js")
//
//        do {
//            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
//            let harness = JSBundleHarness(forBundle: mainBundle, withRootView: flexRoot)
//        } catch {
//            print("Failed to load main bundle!")
//        }
    }

}

