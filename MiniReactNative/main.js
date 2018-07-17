const global = Function('return this')();

class App {
  handleButtonPress() {
    log('OMG BUTTON PRESSED');
    this.render([
      { type: 'Button', color: 'blue', title: 'Rendered' },
      { type: 'Button', color: 'purple', title: 'From JS' }
    ]);
  }

  render() {
    log('RENDERING');
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
