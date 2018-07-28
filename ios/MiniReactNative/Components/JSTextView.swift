import UIKit
import JavaScriptCore

struct JSTextDescriptor {
    let text: String
    let fontSize: CGFloat
    let color: String
    let textAlignment: String?

    init(_ jsValue: JSValue) {
        self.text = toString(jsValue, "text") ?? ""
        self.fontSize = toFloat(jsValue, "fontSize") ?? 20
        self.color = toString(jsValue, "color") ?? "black"
        self.textAlignment = toString(jsValue, "textAlignment")
    }
}

func createUITextView(fromValue descriptor: JSValue) -> UITextView {
    let desc = JSTextDescriptor(descriptor)
    
    let textView: UITextView = createUIView(fromValue: descriptor, ofType: UITextView()) as! UITextView
    
    textView.isEditable = false
    textView.text = desc.text
    textView.font = UIFont.systemFont(ofSize: desc.fontSize)
    textView.textColor = createUIColor(from: desc.color)
    textView.textAlignment = createNSTextAlignment(from: desc.textAlignment)

    return textView
}
