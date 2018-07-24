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
          text: 'Enter a username and press Search.',
          fontSize: 20,
          color: 'black',
        },
        {
          type: 'TextField',
          placeholder: 'Enter Username',
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

    // addOrientationChangeListener(this.renderCards);
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

export default GitHubScreen;
