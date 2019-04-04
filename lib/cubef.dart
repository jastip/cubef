library cubef;

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'arrayutils.dart';

enum Action { none, up, left, down, right }

typedef RollUp = void Function();
typedef RollDown = void Function();
typedef RollLeft = void Function();
typedef RollRight = void Function();

class Cubef extends StatefulWidget {
   final Widget child1, child2, child3, child4, child5, child6;

  final double height, width;
  final AnimationController controller;
  final Curve animationEffect;
  
  RollUp rollUp;

  Cubef(
      {Key key,
      this.child1,
      this.child2,
      this.child3,
      this.child4,
      this.child5,
      this.child6,
      this.height = 200.0,
      this.width = 200.0,
      this.controller,
      this.animationEffect})
      : super(key: key);

  @override
  _CubefState createState() => _CubefState();
}

class _CubefState extends State<Cubef> with SingleTickerProviderStateMixin {
  Animation _animation;
  Tween<double> _tween;

  Action _lastAction = Action.none;

  AnimationController _controller;

  List<Widget> _verticalIndex;
  List<Widget> _horizontalIndex; // initial index of the cube side

  List<Widget> _stackChildren;
  Widget _topWidget;
  Widget _backWidget;

  void initIndexes() {
    // see my blogs for these array setup

    _verticalIndex = [
      widget.child1,
      widget.child2,
      widget.child3,
      widget.child4
    ];

    _horizontalIndex = [
      widget.child1,
      widget.child6,
      widget.child3,
      widget.child5
    ];
  }

  /// This function will re-order the Stack elements, so the final element will be on the top.
  void initStackChildrenTop(Widget child) {
    _stackChildren = <Widget>[
      Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // 0.001 is thin air
            ..translate(0.0, 0.0, -(widget.height / 2)),
          child: Container(
              child: Center(
            child: child,
            key: GlobalKey(),
          ))),
    ];
  }

  /// This function will simulate roll Up or roll Down
  /// so actually, at one time there are only 2 sides in the Stack
  void initStackChildrenRollUpDown() {
    _stackChildren = [
      Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0.0, -((widget.height / 2) * math.cos(_animation.value)),
              ((-widget.height / 2) * math.sin(_animation.value)))
          ..rotateX(-(math.pi / 2) + _animation.value),
        child: Container(
            child: Center(
          child: _backWidget,
          key: GlobalKey(),
        )),
      ),
      Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // 0.001 is thin air
          ..translate(0.0, ((widget.height / 2) * math.sin(_animation.value)),
              -((widget.height / 2) * math.cos(_animation.value)))
          ..rotateX(_animation.value),
        child: Container(
            child: Center(
          child: _topWidget,
          key: GlobalKey(),
        )),
      ),
    ];
  }

  /// This function will simulate roll Left or roll Right
  /// so actually, at one time there are only 2 sides in the Stack
  void initStackChildrenRollLeftRight() {
    _stackChildren = [
      Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(-((widget.width / 2) * math.cos(_animation.value)), 0.0,
              ((-widget.height / 2) * math.sin(_animation.value)))
          ..rotateY(-(math.pi / 2) + _animation.value),
        child: Container(
            child: Center(
          child: _backWidget,
          key: GlobalKey(),
        )),
      ),
      Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // 0.001 is thin air
          ..translate(((widget.width / 2) * math.sin(_animation.value)), 0.0,
              -((widget.height / 2) * math.cos(_animation.value)))
          ..rotateY(_animation.value),
        child: Container(
            child: Center(
          child: _topWidget,
          key: GlobalKey(),
        )),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000));
    } else {
      _controller = widget.controller;
    }

    _tween = Tween(begin: 0.0, end: math.pi / 2);

    _animation = _tween.animate(CurvedAnimation(
        parent: _controller,
        curve: (widget.animationEffect == null)
            ? Curves.elasticInOut
            : widget.animationEffect));

    _controller.addListener(() {
      setState(() {
        switch (_lastAction) {
          case Action.down:
            {
              initStackChildrenRollUpDown();
            }
            break;

          case Action.up:
            {
              initStackChildrenRollUpDown();
            }
            break;

          case Action.left:
            {
              initStackChildrenRollLeftRight();
            }
            break;

          case Action.right:
            {
              initStackChildrenRollLeftRight();
            }
            break;

          case Action.none:
            {}
            break;
        }

        /// This will replace the top Element when before the animation ended.
        if ((_tween.end >= _tween.begin &&
                _animation.value >= _tween.end - 0.2) ||
            (_tween.end < _tween.begin &&
                _animation.value <= _tween.end + 0.2)) {
          initStackChildrenTop(_backWidget);
        }
      });
    });

    /// First initialize of the top and back widget
    _topWidget = widget.child1;
    _backWidget = widget.child1;

    initStackChildrenTop(widget.child1);
    initIndexes();
  }

  /// Start roll-up cube animation
  void rollUp() {
    _topWidget = _backWidget;
    _verticalIndex = ArrayUtils.moveRight(_verticalIndex);
    _horizontalIndex[0] = _verticalIndex[0];
    _horizontalIndex[2] = _verticalIndex[2];
    _backWidget = _verticalIndex[0];
    _lastAction = Action.up;
    _tween.begin = 0.0;
    _tween.end = -(math.pi / 2);
    _controller.reset();
    _controller.forward();
  }

  /// Start roll-down cube animation
  void rollDown() {
    _topWidget = _backWidget;
    _verticalIndex = ArrayUtils.moveLeft(_verticalIndex);
    _horizontalIndex[0] = _verticalIndex[0];
    _horizontalIndex[2] = _verticalIndex[2];
    _backWidget = _verticalIndex[0];
    _lastAction = Action.down;
    _tween.begin = 0.0;
    _tween.end = (math.pi / 2);
    _controller.reset();
    _controller.forward();
  }

  /// Start roll-right cube animation
  void rollRight() {
    _topWidget = _backWidget;
    _horizontalIndex = ArrayUtils.moveLeft(_horizontalIndex);
    _verticalIndex[0] = _horizontalIndex[0];
    _verticalIndex[2] = _horizontalIndex[2];
    _backWidget = _horizontalIndex[0];
    _lastAction = Action.left;
    _tween.begin = 0.0;
    _tween.end = (math.pi / 2);
    _controller.reset();
    _controller.forward();
  }

  /// Start roll-left cube animation
  void rollLeft() {
    _topWidget = _backWidget;
    _horizontalIndex = ArrayUtils.moveRight(_horizontalIndex);
    _verticalIndex[0] = _horizontalIndex[0];
    _verticalIndex[2] = _horizontalIndex[2];
    _backWidget = _horizontalIndex[0];
    _lastAction = Action.left;
    _tween.begin = 0.0;
    _tween.end = -(math.pi / 2);
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext contex) {
    return Center(
      child: Expanded(
        child: Container(
          height: widget.height,
          width: double.infinity,
          child: Stack(
            alignment: FractionalOffset.center,
            children: _stackChildren,
          ),
        )
      ),
    );
  }
}
