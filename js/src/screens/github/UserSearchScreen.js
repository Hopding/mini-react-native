import Component from '../../core/Component';

const TopSectionView = ({ onChangeUsername, onPressSearch }) => ({
  type: 'View',
  alignItems: 'center',
  backgroundColor: 'white',
  children: [
    {
      type: 'Text',
      text: 'Enter a username and press Search.',
      fontSize: 20,
      color: 'black'
    },
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
  entries = [];
  keys = ['login', 'id', 'type', 'company', 'blog', 'location', 'email', 'bio'];

  handleJson = json => {
    this.inputText = '';
    this.entries = this.keys.map(key => [key, json[key]]);
    this.rerender();
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
          onPressSearch: () => {
            fetchJson(`https://api.github.com/users/${this.inputText}`).then(
              this.handleJson
            );
          }
        }),
        {
          type: 'CollectionView',
          flex: 1,
          backgroundColor: 'white',
          itemsPerSection: this.entries.length,
          sectionInsets: {
            top: 10,
            bottom: 10,
            left: 10,
            right: 10
          },
          itemSize: {
            width: screenWidth(),
            height: 75
          },
          renderItem: cellIndex => ({
            type: 'View',
            flex: 1,
            backgroundColor: 'white',
            children: [
              {
                type: 'Text',
                text: this.entries[cellIndex][0],
                color: 'black',
                fontSize: 15
              },
              {
                type: 'Text',
                text: this.entries[cellIndex][1],
                color: 'black',
                fontSize: 20
              }
            ]
          })
        }
      ]
    };
  };
}

export default UserSearchScreen;
