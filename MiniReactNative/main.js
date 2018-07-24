const global = Function('return this')();

log(Object.keys(global));

fetch = (url, config) =>
  new Promise((resolve, reject) => {
    makeHttpRequest({
      url: url,
      method: (config || {}).method || 'GET',
      callback: response => {
        if (response.statusCode === 200) {
          resolve(response);
        } else {
          reject(response);
        }
      },
    });
  });

fetchJson = (url, config) =>
  fetch(url, config).then(({ data }) => JSON.parse(data));

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
        {
          type: 'Button',
          title: 'GitHub Data Screen',
          color: 'blue',
          onPress: () => navigate(GitHubScreen),
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

class GitHubScreen {
  constructor(render) {
    this.render = render;

    this.handleJson = this.handleJson.bind(this);

    this.inputText = '';

    this.topSectionView = {
      type: 'View',
      alignItems: 'center',
      backgroundColor: 'white',
      children: [
        {
          type: 'Text',
          text: 'GitHub Search Tool',
          fontSize: 30,
          color: 'black',
        },
        {
          type: 'Text',
          text: 'Enter a username and press Search.',
          fontSize: 20,
          color: 'black',
        },
        {
          type: 'TextField',
          width: 175,
          height: 40,
          borderColor: 'gray',
          borderWidth: 1,
          borderRadius: 5,
          onPress: newText => {
            this.inputText = newText;
          },
        },
        {
          type: 'Button',
          color: 'blue',
          title: 'Search',
          borderColor: 'blue',
          borderWidth: 1,
          borderRadius: 5,
          margin: 15,
          paddingLeft: 25,
          paddingRight: 25,
          onPress: () => {
            fetchJson(`https://api.github.com/users/${this.inputText}`).then(
              this.handleJson,
            );
          },
        },
      ],
    };

    this.keys = [
      'login',
      'id',
      'type',
      'company',
      'blog',
      'location',
      'email',
      'bio',
    ];

    this.render(this.topSectionView);
  }

  handleJson(json) {
    this.inputText = '';
    const entries = this.keys.map(key => [key, json[key]]);
    this.render({
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        this.topSectionView,
        {
          type: 'CollectionView',
          flex: 1,
          backgroundColor: 'white',
          itemsPerSection: entries.length,
          sectionInsets: {
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
          },
          itemSize: {
            width: screenWidth(),
            height: 75,
          },
          renderItem: cellIndex => ({
            type: 'View',
            flex: 1,
            backgroundColor: 'white',
            children: [
              {
                type: 'Text',
                text: entries[cellIndex][0],
                color: 'black',
                fontSize: 15,
              },
              {
                type: 'Text',
                text: entries[cellIndex][1],
                color: 'black',
                fontSize: 20,
              },
            ],
          }),
        },
      ],
    });
  }
}

navigate(InitialScreen);
