import Foundation
import UIKit
import JavaScriptCore

struct ViewDescriptor: Codable {
    let type: String
    let color: String
    let title: String
    let children: [ViewDescriptor]?
}

class ViewDescriptorRenderer {
    let rootView: UIView
    
    init(rootView: UIView) {
        self.rootView = rootView
    }
    
    func render(_ viewDescriptors: [ViewDescriptor]) {
        rootView.subviews.forEach({ $0.removeFromSuperview() })
        for (index, descriptor) in viewDescriptors.enumerated() {
            if (descriptor.type == "Button") {
                let button = UIButton(frame: CGRect(x: 100, y: 100 * index, width: 100, height: 50))
                button.backgroundColor = UIColorFrom(descriptor.color)
                button.setTitle(descriptor.title, for: .normal)
                //                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
                if let children = descriptor.children {
                    let vdr = ViewDescriptorRenderer(rootView: button)
                    vdr.render(children)
                }

                rootView.addSubview(button)
            }
        }
    }
}
