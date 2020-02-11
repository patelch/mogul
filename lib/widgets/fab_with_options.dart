import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'dart:math' as math;

class FabWithOptions extends StatefulWidget {

  final List<FabOption> fabOptions;

  /// Max size of 4
  FabWithOptions({ this.fabOptions = const [] });

  @override
  _FabWithOptionsState createState() => _FabWithOptionsState();
}

class _FabWithOptionsState extends State<FabWithOptions> with SingleTickerProviderStateMixin {

  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _animateOptions;
  Animation _curve;

  @override
  void initState() {

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animateIcon = Tween<double>(
      begin: 0,
      end: math.pi / 4,
    ).animate(_curve);

    _animateOptions = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(_curve);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  List<Widget> _buildOptionButtons() {
    List<Widget> optionButtons = [];

    int numButtons = widget.fabOptions.length;
    double angle = 180 / (numButtons + 1);

    for (FabOption fabOption in widget.fabOptions) {

      final double rad = radians(angle);

      Transform button = Transform(
        transform: Matrix4.identity()..translate(
          (_animateOptions.value) * -math.cos(rad),
          (_animateOptions.value) * -math.sin(rad),
        ),
        child: FloatingActionButton(
          child: Icon(fabOption.icon),
          onPressed: () {
            animate();
            fabOption.onPressed();
          },
          elevation: 0,
        ),
      );

      optionButtons.add(button);

      angle += 180 / (numButtons + 1);

    }

    return optionButtons;
  }
  
  @override
  Widget build(BuildContext context) {

    double height = 250;
    double width = MediaQuery.of(context).size.width;

    double yAlign = kBottomNavigationBarHeight / (height / 2);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, builder) {

        List<Widget> fabWithOptions = _buildOptionButtons();
        fabWithOptions.add(
          Transform.rotate(
            angle: _animateIcon.value,
            child: FloatingActionButton(
              elevation: 0,
              child: Icon(LineIcons.plus),
              onPressed: () {
                animate();
              },
            ),
          ),
        );

        return Container(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment(0, yAlign),
            children: fabWithOptions,
          ),
        );
      },
    );
  }
}

class FabOption {
  final IconData icon;
  final Function onPressed;

  FabOption({ this.icon, this.onPressed });
}
