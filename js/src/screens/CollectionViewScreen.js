import Component, { orientationSensitive } from '../core/Component';

@orientationSensitive
class CollectionViewScreen extends Component {
  itemsPerSection = 0;

  handleAddCard = () => {
    this.itemsPerSection += 1;
    this.rerender();
  };

  render = () => {
    return {
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        {
          type: 'Button',
          title: 'Add Card',
          color: 'blue',
          onPress: this.handleAddCard
        },
        {
          type: 'CollectionView',
          flex: 1,
          itemsPerSection: this.itemsPerSection,
          minimumLineSpacing: 2,
          sectionInsets: {
            top: 0,
            bottom: 0,
            left: 0,
            right: 0
          },
          itemSize: {
            width: screenWidth(),
            height: 60
          },
          renderItem: cellIndex => ({
            type: 'View',
            flex: 1,
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: 'orange',
            children: [
              {
                type: 'Button',
                title: cellIndex,
                color: 'blue',
                onPress: () => log(`Cell Index: ${cellIndex}`)
              }
            ]
          })
        }
      ]
    };
  };
}

export default CollectionViewScreen;
