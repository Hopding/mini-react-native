import UIKit
import JavaScriptCore

func createUIComponent(fromValue descriptor: JSValue) -> UIView? {
    switch toString(descriptor, "type") {
    case "Button": return createUIButton(fromValue: descriptor)
    case "View":   return createUIView(fromValue: descriptor)
    default:       return nil
    }
}
