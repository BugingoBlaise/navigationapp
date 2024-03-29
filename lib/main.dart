import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:navigationapp/calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      home: ThemPage(
        child: HomeScreen(), // Wrap HomeScreen with ThemPage
      ),
    );
  }
}

class ThemPage extends StatefulWidget {
  final Widget child; // Child widget to be wrapped with ThemPage

  const ThemPage({Key? key, required this.child}) : super(key: key);

  @override
  _ThemPageState createState() => _ThemPageState();
}

bool themeColor = false;
dynamic colorTheme() {
  if (themeColor) {
    return Colors.black;
  } else {
    return Colors.blue[200];
  }
}

class _ThemPageState extends State<ThemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                themeColor = !themeColor;
              });
            },
            icon: themeColor
                ? Icon(
                    Icons.brightness_3,
                    color: themeColor ? Colors.blue[200] : Colors.black,
                  )
                : Icon(
                    Icons.wb_sunny,
                    color: themeColor ? Colors.blue[200] : Colors.black,
                  ),
          )
        ],
      ),
      body: widget.child, // Display the child widget
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool isDarkMode = true;

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Image.asset(
      'assets/onee.jpg',
      height: double.infinity,
      fit: BoxFit.cover,
    ),
    Container(child: Calculator()),
    Image.asset(
      'assets/background.jpg',
      height: double.infinity,
      fit: BoxFit.cover,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student App'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Student',
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('My Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Switch Theme'),
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: isDarkMode ? Colors.black : Colors.white,
                    statusBarBrightness:
                        isDarkMode ? Brightness.light : Brightness.dark,
                  ));
                  FlutterStatusbarcolor.setStatusBarColor(
                    isDarkMode ? Colors.black : Colors.white,
                  );
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                print('Logout tapped');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;

  TabScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// class Calculator extends StatefulWidget {
//   @override
//   State<Calculator> createState() => _CalculatorState();
// }

// class _CalculatorState extends State<Calculator> {
//   String userInput = "";
//   String result = "0";

//   List<String> buttonString = [
//     'AC',
//     '(',
//     ')',
//     '/',
//     '7',
//     '8',
//     '9',
//     '*',
//     '4',
//     '5',
//     '6',
//     '+',
//     '1',
//     '2',
//     '3',
//     '-',
//     'C',
//     '0',
//     '.',
//     '='
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1d2630),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: EdgeInsets.all(10),
//             alignment: Alignment.centerRight,
//             child: Text(
//               userInput,
//               style: TextStyle(
//                 fontSize: 22,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             alignment: Alignment.centerRight,
//             child: Text(
//               result,
//               style: TextStyle(
//                 fontSize: 38,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 50),
//           Divider(color: Colors.white),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               child: GridView.builder(
//                 itemCount: buttonString.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return CustomButton(buttonString[index]);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget CustomButton(String text) {
//     return InkWell(
//       splashColor: Color(0xFF1d2630),
//       onTap: () {
//         setState(() {
//           handleButtons(text);
//         });
//       },
//       child: Ink(
//         decoration: BoxDecoration(
//           color: getBgColor(text),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withOpacity(0.1),
//               blurRadius: 4,
//               spreadRadius: 0.5,
//               offset: Offset(-3, -3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: getColor(text),
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   getColor(String text) {
//     if (text == '/' ||
//         text == '*' ||
//         text == '+' ||
//         text == '-' ||
//         text == '(' ||
//         text == ')') {
//       return Color.fromARGB(255, 252, 100, 100);
//     }
//     return Colors.white;
//   }

//   getBgColor(String text) {
//     if (text == 'AC') {
//       return Color.fromARGB(255, 252, 100, 100);
//     }
//     if (text == '=') {
//       return Color.fromARGB(255, 104, 104, 159);
//     }
//     return Color(0xFF1d2630);
//   }

//   handleButtons(String text) {
//     if (text == 'AC') {
//       userInput = '';
//       result = '0';
//       return;
//     }
//     if (text == 'C') {
//       if (userInput.isNotEmpty) {
//         userInput = userInput.substring(0, userInput.length - 1);
//       } else {
//         return null;
//       }
//     }

//     if (text == '=') {
//       result = calculate();

//       if (userInput.endsWith('.0')) {
//         userInput = userInput.replaceAll('.0', '');
//       }
//       if (result.endsWith('.0')) {
//         result = result.replaceAll('.0', '');
//         return;
//       }
//     }

//     userInput = userInput + text;
//   }

//   String calculate() {
//     try {
//       var exp = Parser().parse(userInput);
//       var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
//       return evaluation.toString();
//     } catch (e) {
//       return 'Error';
//     }
//   }
// }
