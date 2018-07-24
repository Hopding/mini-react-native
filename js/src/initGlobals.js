// const global = Function('return this')();

log(Object.keys(global));

fetch = (url, config) =>
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
      },
    });
  });

fetchJson = (url, config) =>
  fetch(url, config).then(({ data }) => JSON.parse(data));
