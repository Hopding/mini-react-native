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
      color: 'blue',
      children: [
        {
          type: 'Button',
          color: 'green',
          title: 'Add Red Card!',
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
          color: 'blue',
          children: [
            {
              type: 'Button',
              color: 'green',
              title: 'Add Red Card!',
              width: 100,
              height: 50,
              onPress: this.handleChange,
            },
            {
              type: 'Button',
              color: 'purple',
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
          color: 'red',
        },
      ],
    });
  }
}

navigate(NavigationCard);
setTimeout(() => {
  navigate(NavigationCard);
}, 1000);
