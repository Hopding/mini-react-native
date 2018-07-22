import UIKit
import FlexLayout

class FlexRoot: UIView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.darkGray
        self.flex.direction(.column)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = (self.superview?.frame)!
        
        let guide = self.superview!.safeAreaLayoutGuide
        let safeAreaHeight = self.frame.height - guide.layoutFrame.size.height

        self.flex
            .paddingTop(safeAreaHeight)
            .width(100%)
            .height(100%)
//            .top(0)
//            .left(0)
//            .width(self.frame.width)
//            .height(self.frame.height)
        self.flex.layout(mode: .fitContainer)
    }
}
