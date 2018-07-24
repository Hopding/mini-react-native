class CollectionViewScreen {
  constructor(render) {
    this.render = render;

    this.itemsPerSection = 0;

    this.handleAddCard = this.handleAddCard.bind(this);
    this.renderCards = this.renderCards.bind(this);

    addOrientationChangeListener(this.renderCards);

    this.renderCards();
  }

  handleAddCard() {
    this.itemsPerSection += 1;
    this.renderCards();
  }

  renderCards() {
    this.render({
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        {
          type: 'Button',
          title: 'Add Card',
          color: 'blue',
          onPress: this.handleAddCard,
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
            right: 0,
          },
          itemSize: {
            width: screenWidth(),
            height: 60,
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
                onPress: () => log(`Cell Index: ${cellIndex}`),
              },
            ],
          }),
        },
      ],
    });
  }
}

export default CollectionViewScreen;
