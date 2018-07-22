import UIKit
import JavaScriptCore
import FlexLayout

func createUIColor(from string: String?) -> UIColor {
    switch string {
    case "transparent": return UIColor(white: 1, alpha: 0.0)
    case "green":       return UIColor.green
    case "blue":        return UIColor.blue
    case "red":         return UIColor.red
    case "yellow":      return UIColor.yellow
    case "purple":      return UIColor.purple
    case "cyan":        return UIColor.cyan
    case "white":       return UIColor.white
    case "black":       return UIColor.black
    default:            return UIColor(white: 1, alpha: 0.0)
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

func createFlexDirection(from string: String?) -> Flex.Direction {
    switch string {
    case "column":        return Flex.Direction.column
    case "row":           return Flex.Direction.row
    case "columnReverse": return Flex.Direction.columnReverse
    case "rowReverse":    return Flex.Direction.rowReverse
    default:              return Flex.Direction.column
    }
}

func toFunc(_ value: JSValue, _ propertyName: String) -> () -> Void {
    return { value.forProperty(propertyName).call(withArguments: []) }
}

func toInt(_ value: JSValue, _ propertyName: String) -> Int? {
    if let num = value.forProperty(propertyName) {
        return num.isNumber ? Int(num.toInt32()) : nil
    }
    return nil
}

func toFloat(_ value: JSValue, _ propertyName: String) -> CGFloat? {
    if let num = value.forProperty(propertyName) {
        return num.isNumber ? CGFloat(num.toDouble()) : nil
    }
    return nil
}

func toString(_ value: JSValue, _ propertyName: String) -> String? {
    if let str = value.forProperty(propertyName) {
        return str.isString ? str.toString() : nil
    }
    return nil
}

func toArray(_ value: JSValue) -> [JSValue] {
    let size = toInt(value, "length")!
    var array: [JSValue] = []
    var i = 0
    while i < size {
        array.append(value.atIndex(i))
        i += 1
    }
    return array
}
