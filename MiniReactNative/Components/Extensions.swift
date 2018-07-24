import UIKit

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
