import Foundation
import JavaScriptCore

@objc protocol FooProtocol : JSExport {
    var bar: String { get set }
    static func createWithBar(_ bar: String) -> Foo
}

@objc class Foo: NSObject, FooProtocol {
    dynamic var bar: String
    
    init(bar: String) {
        self.bar = bar
    }
    
    class func createWithBar(_ bar: String) -> Foo {
        return Foo(bar: bar)
    }
}

@objc protocol ButtonProtocol: JSExport {
    var title: String { get set }
    var onPress: JSValue { get set }
    static func createWithTitleAndOnPress(_ title: String, _ onPress: JSValue) -> Button
}

@objc class Button: NSObject, ButtonProtocol {
    dynamic var title: String
    dynamic var onPress: JSValue
    
    init(title: String, onPress: JSValue) {
        self.title = title
        self.onPress = onPress
    }

    static func createWithTitleAndOnPress(_ title: String, _ onPress: JSValue) -> Button {
        return Button(title: title, onPress: onPress)
    }
    
}

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
    
    func injectGlobal(value: @escaping (Foo) -> Void, withName name: String) {
        let castedFunc: @convention(block) (Foo) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    func injectGlobal(value: @escaping (Button) -> Void, withName name: String) {
        let castedFunc: @convention(block) (Button) -> Void = value;
        injectObject(ofValue: castedFunc, withName: name)
    }
    
    private func injectObject<T>(ofValue value: T, withName name: String) {
        jsContext.setObject(
            unsafeBitCast(value, to: AnyObject.self),
            forKeyedSubscript: name as NSCopying & NSObjectProtocol
        )
    }
}
