import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tic Tac Toe Singleplayer',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.keyboard_return),
                    onPressed: () => {
                          runApp(const MaterialApp(
                            title: 'Navigation Basics',
                            home: FirstRoute(),
                          ))
                        }),
              ],
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              title: const Text("Tic Tac Toe Singleplayer"),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/sfondo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Grid(), /* add child content here */
            )));
  }
}

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  var boxes = ['', '', '', '', '', '', '', '', ''];
  int turn = 0;
  int scoreX = 0;
  int scoreO = 0;

  void press(index) {
    setState(() {
      if (boxes[index] == '') {
        boxes[index] = 'X';
        turn++;
        if (turn < 9) {
          play();
        }
        checkWinner();
      }
    });
  }

  void play() {
    Random random = Random();

    int num = random.nextInt(9);
    while (boxes[num] != '') {
      num = random.nextInt(9);
    }
    setState(() {
      boxes[num] = 'O';
      turn++;
    });
    checkWinner();
  }

  void showWinDialog(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }

  void clearGrid() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        boxes[i] = '';
      }
      turn = 0;
    });
  }

  void checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (int i = 0; i < lines.length; i++) {
      var pos = lines[i];
      if (boxes[pos[0]] == boxes[pos[1]] &&
          boxes[pos[1]] == boxes[pos[2]] &&
          boxes[pos[0]] != '') {
        if (boxes[pos[0]] == 'X') {
          showWinDialog("Hai vinto");
          scoreX++;
        } else {
          showWinDialog("Hai perso");
          scoreO++;
        }
        clearGrid();
        return;
      }
    }
    if (turn == 9) {
      showWinDialog("Pareggio");
      clearGrid();
    }
  }

  void printScoreX(int scoreX) {
    print(scoreX.toString());
  }

  void printScoreO(int scoreO) {
    print(scoreO.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ElevatedButton(
            onPressed: () => press(index),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.purpleAccent[200]),
            child: Center(
                child:
                    Text(boxes[index], style: const TextStyle(fontSize: 80))));
      },
    );
  }
}

//BOTTONI

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/sfondo.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          title: const Text('Game Menu'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text('Singleplayer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text('Multiplayer'),
            ),
          ],
        )),
      )
    ]);
  }
}

//BOTTONE SINGLE PLAYER

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    runApp(const MyApp());

    return Scaffold();
  }
}

//BOTTONE MULTI PLAYER

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    runApp(const MultiPlayer());

    return Scaffold();
  }
}

//TRIS MULTIPLAYER
class MultiPlayer extends StatelessWidget {
  const MultiPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tic Tac Toe Multiplayer',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.keyboard_return),
                  onPressed: () => {
                        runApp(const MaterialApp(
                          title: 'Navigation Basics',
                          home: FirstRoute(),
                        ))
                      }),
            ],
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            title: const Text("Tic Tac Toe Multiplayer"),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sfondo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Griglia(), /* add child content here */
          ),
        ));
  }
}

class Griglia extends StatefulWidget {
  const Griglia({Key? key}) : super(key: key);

  @override
  GrigliaStato createState() => GrigliaStato();
}

class GrigliaStato extends State<Griglia> {
  var boxes = ['', '', '', '', '', '', '', '', ''];
  int turn = 0;

  void press(index) {
    setState(() {
      if (((turn % 2) == 0) && boxes[index] == '') {
        boxes[index] = 'X';
        turn++;
      } else if (boxes[index] == '') {
        boxes[index] = 'O';
        turn++;
      }
      checkWinner();
    });
  }

  void play() {
    setState(() {
      turn++;
    });
    checkWinner();
  }

  void showWinDialog(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }

  void clearGrid() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        boxes[i] = '';
      }
      turn = 0;
    });
  }

  void checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (int i = 0; i < lines.length; i++) {
      var pos = lines[i];
      if (boxes[pos[0]] == boxes[pos[1]] &&
          boxes[pos[1]] == boxes[pos[2]] &&
          boxes[pos[0]] != '') {
        if (boxes[pos[0]] == 'X') {
          showWinDialog("Ha vinto X");
        } else {
          showWinDialog("Ha vinto O");
        }
        clearGrid();
        return;
      }
    }
    if (turn == 9) {
      showWinDialog("Pareggio");
      clearGrid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ElevatedButton(
            onPressed: () => press(index),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.deepPurple[200]),
            child: Center(
                child:
                    Text(boxes[index], style: const TextStyle(fontSize: 80))));
      },
    );
  }
}
