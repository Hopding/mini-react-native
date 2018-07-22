const global = Function('return this')();

log(Object.keys(global));

const colorMap = {
  red: 'blue',
  purple: 'green',
  blue: 'red',
  green: 'purple',
};

// const makeButtons = (color1, color2) => [
//   {
//     type: 'View',
//     x: 25,
//     y: 25,
//     width: 350,
//     height: 600,
//     color: 'black',
//     children: [
//       {
//         type: 'Button',
//         x: 100,
//         y: 100,
//         width: 100,
//         height: 50,
//         color: color1,
//         title: 'JS Test 1',
//         onPress: () => {
//           log(`${color1} Button Pressed!`);
//           renderButtons(colorMap[color1], colorMap[color2]);
//         }
//       },
//       {
//         type: 'Button',
//         x: 100 + 100 + 25,
//         y: 100,
//         width: 100,
//         height: 50,
//         color: color2,
//         title: 'JS Test 2',
//         onPress: () => {
//           log(`${color2} Button Pressed!`);
//           renderButtons(colorMap[color1], colorMap[color2]);
//         }
//       }
//     ]
//   }
// ];
//
// const renderButtons = (color1, color2) => render(makeButtons(color1, color2));
//
// renderButtons('red', 'purple');

render([
  {
    type: 'View',
    flex: 1,
    color: 'black',
    children: [
      {
        type: 'View',
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        // width: 1,
        height: 1,
        color: 'purple',
        children: [
          {
            type: 'Button',
            color: 'red',
            width: 100,
            height: 25,
            // flex: 1,
            title: 'Press Me!',
            onPress: () => {
              log('Tee hee, that tickles!');
            },
          },
        ],
      },
      {
        type: 'View',
        flex: 1,
        // width: 1,
        height: 1,
        color: 'green',
      },
      {
        type: 'View',
        flex: 1,
        // width: 1,
        height: 1,
        color: 'blue',
      },
    ],
  },
]);
