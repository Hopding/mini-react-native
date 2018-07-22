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
    // width: 150,
    // height: 150,
    flex: 1,
    color: 'black',
    children: [
      {
        type: 'View',
        width: 25,
        height: 25,
        color: 'purple',
      },
      {
        type: 'View',
        width: 50,
        height: 50,
        color: 'green',
      },
      {
        type: 'View',
        width: 75,
        height: 75,
        color: 'blue',
      },
    ],
  },
]);
