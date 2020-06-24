import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'var.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> membre = ["left hand", "right hand", "left foot", "right foot"];
  List x = [1, 2, 3, 4];
  List y = [1, 2, 3, 4, 5];
  int rows = 0;
  int columns = 0;
  int r = 0;
  bool active = false;
  var random = Random();
  int i = 0;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  bool newGame = true;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  
  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future speak(String cmd) async {
    await flutterTts.setLanguage("fr-FR");
    await flutterTts.setVolume(1.0);
    var result = await flutterTts.speak(cmd);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    if(newGame == true) {
      r = random.nextInt(x.length * y.length);
      placeMatch(r);
      speak("${names[i]},${membre[i]} $rows, $columns");
      newGame = false;
    }
    colors(isDark, context);
    return Scaffold(
      backgroundColor: background,
      body: GestureDetector(
        onTap: () {
          randomGen();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: p1,
                        onPressed: () => Navigator.of(context).pop(),)
                    ),
                  ),
                  Center(
                    child: Text("${names[i]},\n${membre[i]}", style: textStyle),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: x.length),
                      itemCount: x.length * y.length,
                      itemBuilder: (context, index) {
                          if(r == index)
                            active = true;
                          else
                            active = false;   
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new NeuRoundedRectangle(
                              width: 50, height: 50, radius: Radius.circular(20), active: active,
                              ),
                          );
                      }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  placeMatch(r) {
    setState(() {
    if (r == 0 || r == 4 || r == 8 || r == 12 || r == 16) {
      rows = 1;
    }
    if (r == 1 || r == 5 || r == 9 || r == 13 || r == 17) {
      rows = 2;
    }
    if (r == 2 || r == 6 || r == 10 || r == 14 || r == 18) {
      rows = 3;
    }
    if (r == 3 || r == 7 || r == 11 || r == 15 || r == 19) {
      rows = 4;
    }
    if (r <= 3)
      columns = 1;
    if (r >= 4 && r <= 7)
      columns = 2;
    if (r >= 8 && r <= 11)
      columns = 3;
    if (r >= 12 && r <= 15)
      columns = 4;
    if (r > 15)
      columns = 5;
      lineColor = colorsList[rows - 1];
    });
  }

  randomGen() {
    r = random.nextInt(x.length * y.length);
    setState(() {
      if(names.length - 1 > i)
        i++;
      else
        i = 0;
    });
    placeMatch(r);
    speak("${names[i]},${membre[i]} $rows, $columns");
    stop();
  }
  
}