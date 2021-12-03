import 'package:flutter/material.dart';
import 'package:torch_compat/torch_compat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ScreenContainer());
  }
}

class ScreenContainer extends StatefulWidget {
  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

const Image LIGHT_OFF_BULB = Image(image: AssetImage('LIGHT_OFF.png'));
const Image LIGHT_ON_BULB = Image(image: AssetImage('LIGHT_ON.png'));

const Color COLOR_ON = Colors.yellow;
const Color COLOR_OFF = Colors.grey;

class _ScreenContainerState extends State<ScreenContainer> {
  bool _isOn = false;

  Color _backgroundColor = COLOR_OFF;
  Image _bulb = LIGHT_OFF_BULB;

  void _changeColor() {
    setState(() {
      _changeBackgroundAndColor(_isOn);
      _isOn = !_isOn;
    });
  }

  void _changeBackgroundAndColor(bool isOn) {
    _backgroundColor = isOn ? COLOR_ON : COLOR_OFF;
    _bulb = isOn
        ? LIGHT_ON_BULB
        : LIGHT_OFF_BULB;
    _handleFlashlight(isOn);
  }

  void _handleFlashlight(bool isOn){
    _workWithFlashlight(isOn);
  }

  void _workWithFlashlight(bool isOn) {
    if (isOn) {
      TorchCompat.turnOn();
      print("LIGHT ON");
    } else {
      print("LIGHT OFF");
      TorchCompat.turnOff();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
        child: Center(
          child: ButtonToChangeColor(_bulb, () {
            _changeColor();
          }),
        ),
      ),
    );
  }
}

class ButtonToChangeColor extends StatelessWidget {
  Function _onTapFunction;
  Image _bulb;

  ButtonToChangeColor(this._bulb, this._onTapFunction);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          _onTapFunction.call();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: _bulb);
  }
}
