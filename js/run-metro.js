const Metro = require('metro');

const [, , serveOrBuild = 'serve'] = process.argv;

if (serveOrBuild === 'build') {
  Metro.runBuild({
    entry: './src/index.js',
    out: '../ios/MiniReactNative/index.js',
    config: Metro.loadMetroConfig(),
  });
} else {
  Metro.runServer({
    port: 8080,
    config: Metro.loadMetroConfig(),
  });
}
