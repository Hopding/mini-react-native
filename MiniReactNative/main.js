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
    render([
      { type: 'Button', color: 'red', title: 'FOO' },
      { type: 'Button', color: 'green', title: 'BAR' },
      { type: 'Button', color: 'blue', title: 'QUX' },
      { type: 'Button', color: 'purple', title: 'BAZ' }
    ]);
  }
}

const app = new App();
app.render();
