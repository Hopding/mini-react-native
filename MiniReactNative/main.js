const global = Function('return this')();

log(Object.keys(global));

class NavigationCard {
  constructor(render) {
    this.render = render;
    this.handleChange = this.handleChange.bind(this);

    render({
      type: 'View',
      flex: 1,
      height: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: 'blue',
      children: [
        {
          type: 'Text',
          backgroundColor: 'transparent',
          color: 'red',
          fontSize: 50,
          text: 'This is a test...',
        },
        {
          type: 'Button',
          title: 'Add Red Card!',
          color: 'cyan',
          width: 100,
          height: 50,
          onPress: this.handleChange,
        },
      ],
    });
  }

  handleChange() {
    log(Object.keys(this));

    this.render({
      type: 'View',
      flex: 1,
      children: [
        {
          type: 'View',
          flex: 1,
          height: 1,
          justifyContent: 'center',
          alignItems: 'center',
          backgroundColor: 'blue',
          children: [
            {
              type: 'Button',
              backgroundColor: 'green',
              title: 'Add Red Card!',
              width: 100,
              height: 50,
              onPress: this.handleChange,
            },
            {
              type: 'Button',
              backgroundColor: 'purple',
              title: 'Go Back',
              width: 100,
              height: 50,
              onPress: navigateBack,
            },
          ],
        },
        {
          type: 'View',
          flex: 1,
          backgroundColor: 'red',
        },
      ],
    });
  }
}

navigate(NavigationCard);
setTimeout(() => {
  navigate(NavigationCard);
}, 1000);
