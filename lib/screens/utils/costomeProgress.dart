import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const CustomProgressIndicator(
      {Key? key, this.size = 50, this.color = Colors.blue})
      : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: _animation.value,
                strokeWidth: 5,
                color: widget.color,
              ),
              Opacity(
                opacity: 1 - _animation.value,
                child: Icon(
                  Icons.refresh,
                  size: widget.size * 0.8,
                  color: widget.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
