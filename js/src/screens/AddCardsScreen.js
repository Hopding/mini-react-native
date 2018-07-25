import Component from '../core/Component';

class AddCardsScreen extends Component {
  cards = [];
  cardColors = ['red', 'green', 'blue', 'yellow', 'purple'];

  handleAddCard = () => {
    const numCards = this.cards.length;
    this.cards.push({
      type: 'View',
      flex: 1,
      height: 1,
      backgroundColor: this.cardColors[(numCards + 1) % this.cardColors.length],
    });
    this.rerender();
  };

  handleRemoveCard = () => {
    this.cards.pop();
    this.rerender();
  };

  render = () => {
    return {
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
    };
  };
}

export default AddCardsScreen;
