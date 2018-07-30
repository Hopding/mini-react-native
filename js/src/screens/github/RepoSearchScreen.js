import _ from 'lodash';

import Component from '../../core/Component';

const SearchTermEntry = ({ onChangeText, onAddTerm }) => ({
  type: 'View',
  flexDirection: 'row',
  justifyContent: 'center',
  alignItems: 'center',
  children: [
    {
      type: 'TextField',
      placeholder: `Enter Search Term`,
      width: 175,
      height: 40,
      borderColor: 'gray',
      borderWidth: 1,
      borderRadius: 5,
      onChangeText,
    },
    {
      type: 'Button',
      backgroundColor: 'blue',
      color: 'white',
      title: 'Add',
      borderColor: 'blue',
      borderWidth: 1,
      borderRadius: 5,
      margin: 15,
      paddingLeft: 15,
      paddingRight: 15,
      onPress: onAddTerm,
    },
  ],
});

const SearchTermList = ({ terms }) => ({
  type: 'View',
  justifyContent: 'center',
  alignItems: 'center',
  flexDirection: 'row',
  children: terms.map(term => ({
    type: 'Text',
    backgroundColor: '#D9D9D9',
    text: term,
    textAlignment: 'center',
    fontSize: 15,
    borderRadius: 16,
    margin: 5,
    paddingLeft: 15,
  })),
});

class RepoSearchScreen extends Component {
  inputText = '';
  // searchTerms = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l'];
  searchTerms = [];
  names = [];

  addSearchTerm = () => {
    if (this.inputText) {
      this.searchTerms.push(this.inputText);
      this.inputText = '';
      this.rerender();
      this.search();
    }
  };

  search = () => {
    const { searchTerms } = this;
    const baseUrl = 'https://api.github.com/search/repositories?q=';
    const searchUrl = `${baseUrl}${searchTerms.join('+').replace(/ /g, '%20')}`;

    return fetchJson(searchUrl).then(json => {
      this.inputText = '';
      this.names = json.items.map(item => item.full_name);
      this.rerender();
    });
  };

  render = () => {
    return {
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      children: [
        SearchTermEntry({
          onChangeText: newText => {
            this.inputText = newText;
          },
          onAddTerm: this.addSearchTerm,
        }),
        SearchTermList({ terms: this.searchTerms }),
        {
          type: 'CollectionView',
          flex: 1,
          backgroundColor: 'white',
          itemsPerSection: this.names.length,
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
                title: this.names[cellIndex],
                onPress: () => openURL(`https://github.com/${this.names[cellIndex]}`)
              },
            ],
          }),
        },
      ],
    };
  };
}

export default RepoSearchScreen;
