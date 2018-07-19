import UIKit
import FlexLayout

class RootFlexView: UIView {
    fileprivate let rootFlexContainer = UIView()

    init() {
        super.init(frame: .zero)
        
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        label.text = "FooBar!"
        
        let bottomLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        label.text = "BottomLabel!"
        
        addSubview(rootFlexContainer)
            // Column container
            rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
                // Row container
                flex.addItem().direction(.row).define { (flex) in
                    flex.addItem(label).width(100)//.aspectRatio(of: label)
                    
                    // Column container
                    flex.addItem().direction(.column).paddingLeft(12).grow(1).define { (flex) in
                        flex.addItem(label)
                    }
                }
                
                flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
                flex.addItem(bottomLabel).marginTop(12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//
//        // 1) Layout the flex container. This example use PinLayout for that purpose, but it could be done
//        //    also by setting the rootFlexContainer's frame:
//        //       rootFlexContainer.frame = CGRect(x: 0, y: 0,
//        //                                        width: frame.width, height: rootFlexContainer.height)
//        rootFlexContainer.pin.top().left().width(100%).marginTop(topLayoutGuide)
        
        // 2) Then let the flexbox container layout itself. Here the container's height will be adjusted automatically.
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}
