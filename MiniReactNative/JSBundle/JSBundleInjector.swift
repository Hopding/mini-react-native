import Foundation
import JavaScriptCore

class JSBundleInjector {
    let jsContext: JSContext
    
    init(for jsContext: JSContext) {
        self.jsContext = jsContext
    }
    
    func injectGlobal(value: @escaping ([String: Any]) -> [String: Any], withName name: String) {
        let castedFunc: @convention(block) ([String: Any]) -> [String: Any] = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (String) -> Void, withName name: String) {
        let castedFunc: @convention(block) (String) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (Array<[String: String]>) -> Void, withName name: String) {
        let castedFunc: @convention(block) (Array<[String: String]>) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (Array<[String: JSValue]>) -> Void, withName name: String) {
        let castedFunc: @convention(block) (Array<[String: JSValue]>) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (JSValue) -> Void, withName name: String) {
        let castedFunc: @convention(block) (JSValue) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (JSValue, Int) -> Void, withName name: String) {
        let castedFunc: @convention(block) (JSValue, Int) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping () -> Void, withName name: String) {
        let castedFunc: @convention(block) () -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping () -> CGFloat, withName name: String) {
        let castedFunc: @convention(block) () -> CGFloat = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func prepForInjection(value: @escaping (JSValue) -> Void) -> AnyObject {
        let castedFunc: @convention(block) (JSValue) -> Void = value;
        return unsafeBitCast(castedFunc, to: AnyObject.self);
    }
    
    private func injectObject<T>(ofValue value: T, withName name: String) {
        jsContext.setObject(
            unsafeBitCast(value, to: AnyObject.self),
            forKeyedSubscript: name as NSCopying & NSObjectProtocol
        )
    }
}


/* ===== Sample object that can be exported to JS ===== */
//@objc protocol ButtonProtocol: JSExport {
//    var title: String { get set }
//    var onPress: JSValue { get set }
//    static func createWithTitleAndOnPress(_ title: String, _ onPress: JSValue) -> Button
//}
//
//@objc class Button: NSObject, ButtonProtocol {
//    dynamic var title: String
//    dynamic var onPress: JSValue
//
//    init(title: String, onPress: JSValue) {
//        self.title = title
//        self.onPress = onPress
//    }
//
//    static func createWithTitleAndOnPress(_ title: String, _ onPress: JSValue) -> Button {
//        return Button(title: title, onPress: onPress)
//    }
//}
