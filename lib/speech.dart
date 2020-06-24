import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';

void main() {
  runApp(new Speech());
}

class Speech extends StatefulWidget {
  @override
  _SpeechState createState() => new _SpeechState();
}

class _SpeechState extends State<Speech> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((bool result) => setState(() => _isAvailable = result));
    _speechRecognition.setRecognitionStartedHandler(() => setState(() => _isListening = true));
    _speechRecognition.setRecognitionResultHandler((String speech) => setState(() => resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler((text) => setState(() => _isListening = false));
    _speechRecognition.activate('fr_FR').then((value) => setState(() => _isAvailable = value));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.cancel),
                    mini: true,
                    backgroundColor: Colors.deepOrange,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.cancel().then(
                              (result) => setState(() {
                                    _isListening = result;
                                    resultText = "";
                                  }),
                            );
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.mic),
                    onPressed: () {
                      if (_isAvailable && !_isListening)
                        _speechRecognition
                            .listen()
                            .then((result) => print('$result'));
                    },
                    backgroundColor: Colors.pink,
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.stop),
                    mini: true,
                    backgroundColor: Colors.deepPurple,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.stop().then(
                              (result) => setState(() => _isListening = result),
                            );
                    },
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent[100],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  resultText,
                  style: TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}