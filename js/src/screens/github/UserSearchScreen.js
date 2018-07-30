import Component from '../../core/Component';

const TopSectionView = ({ onChangeUsername, onPressSearch }) => ({
  type: 'View',
  justifyContent: 'center',
  alignItems: 'center',
  backgroundColor: 'white',
  flexDirection: 'row',
  children: [
    {
      type: 'TextField',
      placeholder: 'Enter Username',
      width: 175,
      height: 40,
      borderColor: 'gray',
      borderWidth: 1,
      borderRadius: 5,
      onChangeText: onChangeUsername
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
      onPress: onPressSearch
    }
  ]
});

class UserSearchScreen extends Component {
  inputText = '';
  items = []

  search = () => {
    const { inputText } = this;
    const baseUrl = `https://api.github.com/search/users?q=${inputText}`;

    return fetchJson(baseUrl).then(json => {
      this.inputText = '';
      this.items = json.items;
      this.rerender();
    });
  };

  render = () => {
    return {
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        TopSectionView({
          onChangeUsername: newText => {
            this.inputText = newText;
          },
          onPressSearch: this.search,
        }),
        {
          type: 'CollectionView',
          flex: 1,
          backgroundColor: 'white',
          itemsPerSection: this.items.length,
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
            margin: 10,
            borderColor: 'lightGray',
            borderWidth: 1,
            borderRadius: 5,
            justifyContent: 'center',
            alignItems: 'center',
            children: [
              {
                type: 'Button',
                flex: 1,
                backgroundColor: 'white',
                title: this.items[cellIndex].login,
                onPress: () => openURL(`https://github.com/${this.items[cellIndex].login}`)
              },
            ],
          }),
        },
      ],
    };
  };
}

export default UserSearchScreen;
