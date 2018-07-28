import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    // let's suppose alpha is the first component (RGBA)
    convenience init(rgba: Int) {
        self.init(
            red: CGFloat((rgba >> 24) & 0xFF),
            green: CGFloat((rgba >> 16) & 0xFF),
            blue: CGFloat((rgba >> 8) & 0xFF),
            alpha: CGFloat(rgba & 0xFF)
        )
    }
}

///////////////////////////////////////

typealias UIButtonTargetClosure = (UIButton) -> ()

class ButtonClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ButtonClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(
                self, &AssociatedKeys.targetClosure,
                ButtonClosureWrapper(newValue),
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    func addTargetClosure(_ closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

///////////////////////////////////////

// yourTextfield.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

typealias UITextFieldTargetClosure = (UITextField) -> ()

class TextFieldClosureWrapper: NSObject {
    let closure: UITextFieldTargetClosure
    init(_ closure: @escaping UITextFieldTargetClosure) {
        self.closure = closure
    }
}

extension UITextField {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UITextFieldTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? TextFieldClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(
                self, &AssociatedKeys.targetClosure,
                TextFieldClosureWrapper(newValue),
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    func addTargetClosure(_ closure: @escaping UITextFieldTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UITextField.closureAction), for: .editingChanged)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
