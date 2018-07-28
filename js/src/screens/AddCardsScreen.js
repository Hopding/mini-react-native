import _ from 'lodash';

import Component from '../core/Component';

class AddCardsScreen extends Component {
  cardColors = ['red', 'green', 'blue', 'yellow', 'purple'];
  cardCount = 0;

  handleAddCard = () => {
    this.cardCount += 1;
    this.rerender();
  };

  handleRemoveCard = () => {
    this.cardCount -= 1;
    this.rerender();
  };

  render = () => {
    const { cardCount, cardColors } = this;

    const cardViews = _(cardCount)
      .range()
      .chunk(3)
      .map((indexes, i) => ({
        type: 'View',
        flex: 1,
        flexDirection: i % 2 === 0 ? 'column' : 'row',
        children: indexes.map(index => ({
          type: 'View',
          flex: 1,
          backgroundColor: cardColors[index % cardColors.length]
        }))
      }))
      .value();

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
              onPress: this.handleAddCard
            },
            {
              type: 'Button',
              title: 'Remove Card',
              color: 'red',
              onPress: this.handleRemoveCard
            }
          ]
        }
      ].concat(cardViews)
    };
  };
}

export default AddCardsScreen;
