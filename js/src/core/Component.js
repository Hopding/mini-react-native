export function orientationSensitive(target) {
  target.orientationSensitive = true;
}

class Component {
  constructor(nativeRender) {
    this.nativeRender = nativeRender;
  }

  rerender = () => {
    this.nativeRender(this.render());
  };
}

export default Component;
