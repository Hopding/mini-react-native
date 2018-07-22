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
      ].concat(this.cards),
    });
  }
}

navigate(InitialScreen);
