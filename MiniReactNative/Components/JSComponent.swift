import UIKit
import JavaScriptCore

func createUIComponent(fromValue descriptor: JSValue) -> UIView? {
    switch toString(descriptor, "type") {
    case "View":   return createUIView(fromValue: descriptor)
    case "Button": return createUIButton(fromValue: descriptor)
    case "Text":   return createUITextView(fromValue: descriptor)
    default:       return nil
    }
}
