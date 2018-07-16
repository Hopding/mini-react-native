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
    
    private func injectObject<T>(ofValue value: T, withName name: String) {
        jsContext.setObject(
            unsafeBitCast(value, to: AnyObject.self),
            forKeyedSubscript: name as NSCopying & NSObjectProtocol
        )
    }
}
