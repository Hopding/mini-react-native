import Component from '../core/Component';

import AddCardsScreen from './AddCardsScreen';
import CollectionViewScreen from './CollectionViewScreen';

import UserSearchScreen from './github/UserSearchScreen';
import RepoSearchScreen from './github/RepoSearchScreen';

class HomeScreen extends Component {
  render = () => {
    return {
      type: 'View',
      flex: 1,
      backgroundColor: 'white',
      justifyContent: 'center',
      alignItems: 'center',
      children: [
        {
          type: 'Text',
          text: 'GitHub Search Tool',
          color: 'black',
          fontSize: 40
        },
        {
          type: 'Button',
          title: 'User Search',
          color: 'blue',
          onPress: () => navigate(UserSearchScreen, 'User Search')
        },
        {
          type: 'Button',
          title: 'Repository Search',
          color: 'blue',
          onPress: () => navigate(RepoSearchScreen, 'Repo Search')
        },
      ]
    };
  };
}

export default HomeScreen;
