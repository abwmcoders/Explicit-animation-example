import 'dart:async';
import 'package:flutter/material.dart';

class BouncingBallDemo extends StatefulWidget {
  const BouncingBallDemo({Key? key}) : super(key: key);

  @override
  State<BouncingBallDemo> createState() => _BouncingBallDemoState();
}

class _BouncingBallDemoState extends State<BouncingBallDemo> {
  late double marginTop;
  late double start;
  late double end;
  late double increment;

  void bounce(Timer t) async {
    if (marginTop < end) {
      setState(() {
        marginTop += increment;
      });
    } else {
      t.cancel();
    }
  }
  showBall () {
    return BouncingBallDemo();
  }

  void interpolate(double start, double end) {
    setState(() {
      increment = (end - start) / 60;
    });
  }

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    start = -5;
    end = 100;
    interpolate(start, end);
    Timer.periodic(const Duration(milliseconds: 16), bounce);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.yellowAccent,
          body: Center(
            child: TextButton(
                onPressed: () {
                  const BouncingBallDemo();
                },
                child: const Text('Press')),
          )),
    );
  }
}

Future<void> main() async {
  runApp(
    const MyApp(),
  );
}

//!
// ignore: must_be_immutable
class AnimatedSnackBar extends StatefulWidget {
  AnimationController animationController;
  final Widget snackContent;
  final double snackHeight;
  final Color snackColor;
  AnimatedSnackBar({
    Key? key,
    this.snackColor = Colors.grey,
    this.snackHeight = 90,
    required this.snackContent,
    required this.animationController,
  }) : super(key: key);

  @override
  _AnimatedSnackBarState createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: widget.animationController,
        ),
        child: Container(
          height: widget.snackHeight,
          width: double.infinity,
          color: widget.snackColor,
          child: widget.snackContent,
        ));
  }
}

//!

class BouncingBallDemoFour extends StatefulWidget {
  const BouncingBallDemoFour({Key? key}) : super(key: key);

  @override
  State<BouncingBallDemoFour> createState() => _BouncingBallDemoFourState();
}

class _BouncingBallDemoFourState extends State<BouncingBallDemoFour>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 100,
        duration: const Duration(seconds: 1));
    controller.addListener(() {});
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: controller.value),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }
}

//!

class BouncingBallDemoThree extends StatefulWidget {
  const BouncingBallDemoThree({Key? key}) : super(key: key);

  @override
  State<BouncingBallDemoThree> createState() => _BouncingBallDemoThreeState();
}

class _BouncingBallDemoThreeState extends State<BouncingBallDemoThree> {
  late String direction;
  late double marginTop;
  late double increment;
  late double start;
  late double end;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    direction = 'down';
    increment = 25;
    start = 0;
    end = 100;
    duration = const Duration(milliseconds: 250);

    Timer.periodic(duration, bounce);
  }

  void setDirection() {
    if (marginTop == end) {
      setState(() {
        direction = 'up';
      });
    }

    if (marginTop == start) {
      setState(() {
        direction = 'down';
      });
    }
  }

  void bounce(Timer t) {
    setDirection();
    setState(() {
      if (direction == 'down') {
        marginTop += increment;
      } else {
        marginTop -= increment;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }
}

//!

class BouncingBallDemoTwo extends StatefulWidget {
  const BouncingBallDemoTwo({Key? key}) : super(key: key);

  @override
  State<BouncingBallDemoTwo> createState() => _BouncingBallDemoTwoState();
}

class _BouncingBallDemoTwoState extends State<BouncingBallDemoTwo> {
  late double marginTop;

  void changePosition(Timer t) async {
    setState(() {
      marginTop = marginTop == 0 ? 100 : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    Timer.periodic(const Duration(seconds: 1), changePosition);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }
}
