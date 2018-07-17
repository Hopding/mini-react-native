const global = Function('return this')();

log(Object.keys(global));
log(Object.getOwnPropertyNames(Foo));
log(Object.getOwnPropertyNames(Button));

class App {
  handleButtonPress() {
    this.render([
      { type: 'Button', color: 'blue', title: 'Rendered' },
      { type: 'Button', color: 'purple', title: 'From JS' }
    ]);
  }

  render() {
    render(
      JSON.stringify([
        { type: 'Button', color: 'red', title: 'FOO' },
        { type: 'Button', color: 'green', title: 'BAR' },
        { type: 'Button', color: 'blue', title: 'QUX' },
        {
          type: 'Button',
          color: 'purple',
          title: 'BAZ',
          children: [
            { type: 'Button', color: 'red', title: '1' },
            { type: 'Button', color: 'green', title: '2' }
          ]
        }
      ])
    );
  }
}

const app = new App();
app.render();

foobar(Foo.createWithBar('BAZ'));
// buttonCallback(Button.createWithTitle("I'm a silly Button!"));
buttonCallback(
  Button.createWithTitleAndOnPress("I'm a silly Button!", () => {
    log('Inside onPress!');
  })
);
// foobar({ bar: 'BAZ' });
