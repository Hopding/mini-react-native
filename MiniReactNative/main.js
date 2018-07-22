const global = Function('return this')();

log(Object.keys(global));

class InitialScreen {
  constructor(render) {
    this.render = render;
    render({
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      justifyContent: 'center',
      alignItems: 'center',
      children: [
        {
          type: 'Text',
          text: 'Welcome!',
          color: 'black',
          fontSize: 50,
        },
        {
          type: 'Button',
          title: 'Next Screen',
          color: 'blue',
          onPress: () => navigate(AddCardsScreen),
        },
        {
          type: 'Button',
          title: 'Collection View Screen',
          color: 'blue',
          onPress: () => navigate(CollectionViewScreen),
        },
      ],
    });
  }
}

class AddCardsScreen {
  constructor(render) {
    this.render = render;

    this.cards = [];
    this.cardColors = ['red', 'green', 'blue', 'yellow', 'purple'];

    this.handleAddCard = this.handleAddCard.bind(this);
    this.handleRemoveCard = this.handleRemoveCard.bind(this);
    this.renderCards = this.renderCards.bind(this);

    this.renderCards();
  }

  handleAddCard() {
    const numCards = this.cards.length;
    this.cards.push({
      type: 'View',
      flex: 1,
      height: 1,
      backgroundColor: this.cardColors[(numCards + 1) % this.cardColors.length],
    });
    this.renderCards();
  }

  handleRemoveCard() {
    this.cards.pop();
    this.renderCards();
  }

  renderCards() {
    this.render({
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        {
          type: 'View',
          flexDirection: 'row',
          justifyContent: 'spaceAround',
          children: [
            {
              type: 'Button',
              title: 'Add Card',
              color: 'blue',
              onPress: this.handleAddCard,
            },
            {
              type: 'Button',
              title: 'Remove Card',
              color: 'red',
              onPress: this.handleRemoveCard,
            },
          ],
        },
      ].concat(this.cards),
    });
  }
}

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
          sectionInsets: {
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
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

navigate(InitialScreen);
