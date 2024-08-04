import 'package:flutter/material.dart';

class ShakeIconButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const ShakeIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ShakeIconButtonState createState() => _ShakeIconButtonState();
}

class _ShakeIconButtonState extends State<ShakeIconButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Faster duration
      vsync: this,
    );

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: -5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -5.0, end: 5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: 0.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  void _shake() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _shake();
        widget.onPressed();
      },
      child: Transform.translate(
        offset: Offset(_animation.value, 0),
        child: widget.icon,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
