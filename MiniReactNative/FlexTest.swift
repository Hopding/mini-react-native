import UIKit
import FlexLayout

class RootFlexView: UIView {
    fileprivate let rootFlexContainer = UIView()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.green
        rootFlexContainer.backgroundColor = UIColor.cyan

        let label2 = UILabel()
        label2.text = "OMG OMG"
        
        let label3 = UILabel()
        label3.text = "GMO GMO"

        addSubview(rootFlexContainer)
        
        rootFlexContainer.frame = self.frame;
        
        // Column container
        rootFlexContainer.flex.direction(.column).grow(1).padding(12).define { (flex) in
            // Row container
            flex.addItem().direction(.row).grow(1).define { (flex) in
                flex.addItem(label2).grow(1)
                flex.addItem(label3).grow(1)
                
//                flex.addItem(label2).width(100).addItem(label3).width(100)

//                    flex.addItem(label2).width(100)//.aspectRatio(of: label)
//
//                    // Column container
//                    flex.addItem().direction(.column).paddingLeft(12).grow(1).define { (flex) in
//                        flex.addItem(label2)
//                    }
            }

//                flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
//                flex.addItem(bottomLabel).marginTop(12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = (self.superview?.frame)!
        
        // 1) Layout the flex container. This example use PinLayout for that purpose, but it could be done
        //    also by setting the rootFlexContainer's frame:
        rootFlexContainer.frame = self.frame;
        // 2) Then let the flexbox container layout itself. Here the container's height will be adjusted automatically.
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
    }
}
