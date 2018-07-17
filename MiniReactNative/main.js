const global = Function('return this')();

log(Object.keys(global));

class Button {
  constructor(title, color, ...children) {
    this.type = 'Button';
    this.title = title;
    this.color = color;
    this.children = children;
  }

  onPress() {
    throw new Error('"onPress" not implemented on ' + this.constructor.name);
  }
}

class MyFirstButton extends Button {
  onPress() {
    log('Logging from MyFirstButton: ' + this.super.title);
  }
}

render([
  new MyFirstButton('FOO', 'red'),
  new MyFirstButton('BAR', 'green'),
  new MyFirstButton(
    'QUX',
    'blue',
    new MyFirstButton('1', 'purple'),
    new MyFirstButton('2', 'purple')
  )
]);
