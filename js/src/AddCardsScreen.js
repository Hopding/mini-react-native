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

export default AddCardsScreen;
