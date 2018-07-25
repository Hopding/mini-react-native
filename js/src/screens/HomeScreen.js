import Component from '../core/Component';

import AddCardsScreen from './AddCardsScreen';
import CollectionViewScreen from './CollectionViewScreen';
import GitHubScreen from './GitHubScreen';

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
          text: 'Welcome!',
          color: 'black',
          fontSize: 50,
        },
        {
          type: 'Button',
          title: 'Next Screen',
          color: 'blue',
          onPress: () => navigate(AddCardsScreen, 'Add Cards'),
        },
        {
          type: 'Button',
          title: 'Collection View Screen',
          color: 'blue',
          onPress: () => navigate(CollectionViewScreen, 'Collection View'),
        },
        {
          type: 'Button',
          title: 'GitHub Data Screen',
          color: 'blue',
          onPress: () => navigate(GitHubScreen, 'GitHub User Search'),
        },
      ],
    };
  };
}

export default HomeScreen;
