import UIKit
import JavaScriptCore

class CollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let desc: JSCollectionViewDescriptor
    
    init(fromDescriptor: JSCollectionViewDescriptor) {
        self.desc = fromDescriptor
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = desc.sectionInsets
        layout.itemSize = desc.itemSize

        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.desc.itemsPerSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let flexRoot = FlexRootView()
        flexRoot.flex.addItem(
            createUIView(fromValue: desc.renderItem(indexPath.item))
        )
        cell.contentView.addSubview(flexRoot)
        return cell
    }
}

struct JSCollectionViewDescriptor {
    let itemsPerSection: Int
    let renderItem: (Int) -> JSValue
    let sectionInsets: UIEdgeInsets
    let itemSize: CGSize

    init(_ jsValue: JSValue) {
        self.itemsPerSection = toInt(jsValue, "itemsPerSection") ?? 1
        self.sectionInsets = UIEdgeInsets(
            top: CGFloat(jsValue.forProperty("sectionInsets").forProperty("top").toDouble()),
            left: CGFloat(jsValue.forProperty("sectionInsets").forProperty("left").toDouble()),
            bottom: CGFloat(jsValue.forProperty("sectionInsets").forProperty("bottom").toDouble()),
            right: CGFloat(jsValue.forProperty("sectionInsets").forProperty("right").toDouble())
        )
        self.itemSize = CGSize(
            width: CGFloat(jsValue.forProperty("itemSize").forProperty("width").toDouble()),
            height: CGFloat(jsValue.forProperty("itemSize").forProperty("height").toDouble())
        )
        self.renderItem = toFunc2(jsValue, "renderItem")
    }
}

func createUICollectionView(fromValue descriptor: JSValue) -> CollectionView {
    let desc = JSCollectionViewDescriptor(descriptor)
    let cv = CollectionView(fromDescriptor: desc)
    let collectionView: CollectionView = createUIView(fromValue: descriptor, ofType: cv) as! CollectionView
    return collectionView
}

