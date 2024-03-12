import 'package:flutter/material.dart';
import '../../Widgets/navbar/src/nav_button.dart';
import './src/nav_clip.dart';
import '../../../utils/constants/colors.dart';
import '../../styles/styles.dart';

typedef _LetIndexPage = bool Function(int value);

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color? buttonBackgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final Gradient buttonBackgroundGradient;
  CurvedNavigationBar({
    Key? key,
    required this.items,
    this.index = 0,
    this.buttonBackgroundColor,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
    required this.buttonBackgroundGradient
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double navHeight = 85.0;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        buildShape( context, navHeight, pos: _pos, length: _length),
        buildIcons(context,navHeight, widget, _pos,  size,  _length, _buttonHide,  _icon),
        SizedBox(
            height: navHeight,
            child: Row(
                children: widget.items.map((item) {
                  return NavButton(
                    onTap: _buttonTap,
                    position: _pos,
                    length: _length,
                    index: widget.items.indexOf(item),
                    child: Center(
                        child: item),
                  );
                }).toList())),
      ],
    );
  }
  Widget buildShape(BuildContext context, double navHeight, {required double pos, required int length}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.elliptical(navHeight *2.5,navHeight/1.5),
      ),
      child: ClipPath(
        clipper: ClipPathClass(
            _pos, _length, Directionality.of(context)
        ),
        child: Container(
          height: navHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:isDarkMode(context) ?[
                PColors.accent3Dark,
                PColors.dark.withOpacity(0.98),
              ] : [
                PColors.accent3Light,
                PColors.navLight.withOpacity(0.93),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildIcons(BuildContext context, double navHeight, CurvedNavigationBar widget, double pos, Size size, int length, double buttonHide, Widget icon) {
    return Positioned(
      bottom:  (navHeight - widget.height) - navHeight/2,
      left: Directionality.of(context) == TextDirection.rtl
          ? null
          : pos * size.width,
      right: Directionality.of(context) == TextDirection.rtl
          ? pos * size.width
          : null,
      width: size.width / length,
      child: Center(
        child: Transform.translate(
          offset: Offset(
            0,
            -(1 - buttonHide) * navHeight,
          ),
          child: Container(
            decoration: PStyles.lightToDark(PColors.accent3Light),
            padding: EdgeInsets.all(navHeight / 8),
            child: icon,
          ),
        ),
      ),
    );
  }

  isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}