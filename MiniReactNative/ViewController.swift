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
    
    var jsPressHandler: JSValue?
    
    func runMainBundle() throws {
        let mainBundleUrl = Bundle.main.url(forResource:"main", withExtension: "js")
        do {
            let mainBundle = try String.init(contentsOf: mainBundleUrl!)
            let jsContext = JSContext()!
            jsContext.exceptionHandler = { context, exception in
                print("JS Error: \(exception)")
            }
            jsContext.evaluateScript(mainBundle)

            let genButton: @convention(block) (String) -> [String: String] = { input in
                return [
                    "type": "Button",
                    "color": "red",
                    "title": "From Swift, Cool!",
                ]
            }
            jsContext.setObject(unsafeBitCast(genButton, to: AnyObject.self), forKeyedSubscript: "genButton" as NSCopying & NSObjectProtocol)
            
            let log: @convention(block) (String) -> Void = { input in
                print(input)
            }
            jsContext.setObject(unsafeBitCast(log, to: AnyObject.self), forKeyedSubscript: "log" as NSCopying & NSObjectProtocol)
            
            jsContext.evaluateScript("const producer = new Producer()")
            let res = jsContext.evaluateScript("producer.produce()")
            jsPressHandler = jsContext.evaluateScript("producer.handleButtonPress")
            
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
    }
    
    @objc func buttonAction(sender: UIButton!) {
        jsPressHandler?.call(withArguments: [])
    }

}

