const { transformSync } = require('@babel/core');

module.exports = {
  projectRoots: [__dirname + '/..'],
  transform: file => transformSync(file.src),
};
