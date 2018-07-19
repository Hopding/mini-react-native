import UIKit
import JavaScriptCore

func createUIColor(from string: String?) -> UIColor {
    switch string {
    case "green":   return UIColor.green
    case "blue":    return UIColor.blue
    case "red":     return UIColor.red
    case "purple":  return UIColor.purple
    default:        return UIColor.black
    }
}

func toFunc(_ value: JSValue, _ propertyName: String) -> () -> Void {
    return { value.forProperty(propertyName).call(withArguments: []) }
}

func toInt(_ value: JSValue, _ propertyName: String) -> Int {
    return Int(value.forProperty(propertyName).toInt32())
}

func toString(_ value: JSValue, _ propertyName: String) -> String {
    return value.forProperty(propertyName).toString();
}

func toArray(_ value: JSValue) -> [JSValue] {
    let size = toInt(value, "length")
    var array: [JSValue] = []
    var i = 0
    while i < size {
        array.append(value.atIndex(i))
        i += 1
    }
    return array
}
