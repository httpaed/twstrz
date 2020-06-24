import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Brightness brightness;
bool isIOS = false;
bool isDark = false;
Color title;
Color p1;
Color background;
Color shadowOne;
Color shadowTwo;
Color accent;
TextStyle textStyle = TextStyle(
  color: p1,
  fontStyle: FontStyle.italic,
  letterSpacing: 3,
  fontSize: 30
);
int players = 0;
List names = [];
List colorsList = [Colors.green, Colors.yellow, Colors.red, Colors.blue];
  Color lineColor;

void colors(bool isDark, BuildContext context) {
  brightness = MediaQuery.platformBrightnessOf(context);
  if(brightness == Brightness.dark)
    isDark = true;
  if(isDark) {
    title = Colors.grey[200];
    p1 = Colors.white54;
    accent = Color.fromARGB(255, 234, 76, 17).withOpacity(0.7);
    background = Color.fromARGB(255,30,33,36);
    shadowOne = Color.fromARGB(255,24,25,29);
    shadowTwo = Color.fromARGB(255,37,41,45);
  } else {
    title = Colors.grey[800];
    p1 = Colors.black54;
    accent = Colors.blueAccent[700];
    background = Colors.grey[200];
    shadowOne = Colors.grey[400];
    shadowTwo = Colors.white;
  }
}

class NeuRoundedRectangle extends StatelessWidget {
  const NeuRoundedRectangle(
    {
    Key key,
    @required this.width,
    @required this.height,
    @required this.radius,
    @required this.active,
    this.child,
    }) : super(key: key);

  final double width;
  final double height;
  final Radius radius;
  final Widget child;
  final bool active;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(radius),
        color: (active) ? lineColor : background,
        boxShadow: [
          BoxShadow(
            color: shadowOne,
            offset: Offset(10, 10),
            blurRadius: 15,
            spreadRadius: -0.5
          ),
          BoxShadow(
            color: shadowTwo,
            offset: Offset(-8, -8),
            blurRadius: 15,
            spreadRadius: -0.5
          ),
        ]
      ),
      child: Center(child: child),
    );
  }
}

enum TtsState { playing, stopped }
