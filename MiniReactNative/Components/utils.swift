import UIKit
import JavaScriptCore
import FlexLayout

func createUIColor(from string: String?) -> UIColor {
    switch string {
    case "green":   return UIColor.green
    case "blue":    return UIColor.blue
    case "red":     return UIColor.red
    case "purple":  return UIColor.purple
    default:        return UIColor.black
    }
}

func createFlexJustifyContent(from string: String?) -> Flex.JustifyContent {
    switch string {
    case "center":       return Flex.JustifyContent.center
    case "end":          return Flex.JustifyContent.end
    case "spaceAround":  return Flex.JustifyContent.spaceAround
    case "spaceBetween": return Flex.JustifyContent.spaceBetween
    case "spaceEvenly":  return Flex.JustifyContent.spaceEvenly
    case "start":        return Flex.JustifyContent.start
    default:             return Flex.JustifyContent.start
    }
}

func createFlexAlignItems(from string: String?) -> Flex.AlignItems {
    switch string {
    case "center":  return Flex.AlignItems.center
    case "end":     return Flex.AlignItems.end
    case "stretch": return Flex.AlignItems.stretch
    case "start":   return Flex.AlignItems.start
    default:        return Flex.AlignItems.stretch
    }
}

func toFunc(_ value: JSValue, _ propertyName: String) -> () -> Void {
    return { value.forProperty(propertyName).call(withArguments: []) }
}

func toInt(_ value: JSValue, _ propertyName: String) -> Int {
    return Int(value.forProperty(propertyName).toInt32())
}

func toFloat(_ value: JSValue, _ propertyName: String) -> CGFloat? {
    if let num = value.forProperty(propertyName) {
        return num.isNumber ? CGFloat(num.toDouble()) : nil
    }
    return nil
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
