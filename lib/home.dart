import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'var.dart';
import 'game.dart';

List<TextEditingController> eCtrl = List();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
    var devHeight = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Text("twstrz".toUpperCase(), style: textStyle,),
              ),
              NeuRoundedRectangle(
                width: devWidth * 0.8, 
                height: 50, 
                radius: Radius.circular(20), 
                active: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: devWidth * 0.6,
                      child: TextField(
                        cursorColor: p1,
                        decoration: InputDecoration(
                          labelText: "enter name here",
                          labelStyle: TextStyle(color: p1),
                          border: InputBorder.none
                        ),
                        controller: _editingController,
                        onSubmitted: (value) {
                          names.add(value);
                          _editingController.clear();
                          setState((){});
                        },
                      )
                    ),
                    NeuRoundedRectangle(
                      width: 30,
                      height: 30,
                      radius: Radius.circular(10),
                      active: false,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.add, size: 15,),
                          onPressed: () {
                            setState(() {
                              names.add(_editingController.text);
                              _editingController.clear();
                            });
                            FocusScope.of(context).requestFocus(new FocusNode());
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             Container( 
              height: devHeight,
              width: devWidth * 0.8,
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuRoundedRectangle(
                      width: devWidth,
                      height: 40,
                      active: false,
                      radius: Radius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(names[i]),
                            NeuRoundedRectangle(
                              width: 30,
                              height: 30,
                              radius: Radius.circular(30),
                              active: false,
                              child: Center(
                                child: IconButton(
                                icon: Icon(Icons.block, size: 15,),
                                onPressed: () {
                                  names.remove(names[i]);
                                  setState((){});
                                }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  );
                 }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: NeuRoundedRectangle(width: 50, height: 50, radius: Radius.circular(50), active: false,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () => (playersNumber()) ? Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return new GamePage();
                  })) : alert("You need at least two players")),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool playersNumber() {
    if(names.length >= 2)
      return true;
    else
      return false;
  }

  Future<void> alert(String error) async {
    Text title = Text("404");
    Text subtitle = Text(error);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: subtitle, actions: <Widget>[okButton(buildContext)],)
              : AlertDialog(title: title, content: subtitle, actions: <Widget>[okButton(buildContext)],);
        }
    );
  }

  FlatButton okButton(BuildContext context) {
    return new FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("ok")
    );
  }

}


  