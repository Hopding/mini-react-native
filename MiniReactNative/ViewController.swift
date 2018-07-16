import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    
    enum JSBundleError: Error {
        case NotPresent
        case FailedToLoad
    }
    
    enum Color: String {
        case green
        case blue
        case red
        case purple
        
        func toUIColor() -> UIColor {
            switch self {
            case Color.green: return UIColor.green
            case Color.blue:  return UIColor.blue
            case Color.red:   return UIColor.red
            case Color.purple:  return UIColor.purple
            }
        }
    }
    
    func runMainBundle() throws {
        let mainBundleUrl = Bundle.main.url(forResource:"main", withExtension: "js")
        do {
            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
            let jsContext = JSContext()!
            jsContext.evaluateScript(mainBundle)
            
            jsContext.evaluateScript("const producer = new Producer()")
            let res = jsContext.evaluateScript("producer.produce()")
            var idx = 0
            for object in res?.toArray() as! Array<[String: String]> {
                let type = object["type"]
                let color = object["color"]
                let title = object["title"]
                if (type == "Button") {
                    let button = UIButton(frame: CGRect(x: 100, y: 100 * idx, width: 100, height: 50))
                    button.backgroundColor = Color(rawValue: color!)!.toUIColor()
                    button.setTitle(title, for: .normal)
                    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                    self.view.addSubview(button)
                }
                idx += 1
            }
        } catch {
            throw JSBundleError.FailedToLoad
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try runMainBundle()
        } catch {
            print("Failed to load main bundle!")
        }
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .green
//        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }

}

