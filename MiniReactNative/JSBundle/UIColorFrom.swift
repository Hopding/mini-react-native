import Foundation
import UIKit

func UIColorFrom(_ string: String?) -> UIColor {
    switch string {
    case "green":   return UIColor.green
    case "blue":    return UIColor.blue
    case "red":     return UIColor.red
    case "purple":  return UIColor.purple
    default:        return UIColor.black
    }
}
