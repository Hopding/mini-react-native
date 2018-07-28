log('Native Globals');
log(Object.keys(global));

global.fetch = (url, config) =>
  new Promise((resolve, reject) => {
    makeHttpRequest({
      url: url,
      method: (config || {}).method || 'GET',
      callback: response => {
        if (response.statusCode === 200) {
          resolve(response);
        } else {
          reject(response);
        }
      }
    });
  });

global.fetchJson = (url, config) =>
  global.fetch(url, config).then(({ data }) => JSON.parse(data));
