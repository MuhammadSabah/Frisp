import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({
    Key? key,
    required this.child,
    required this.isAnimating,
  }) : super(key: key);

  final Widget child;
  final bool isAnimating;

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 150);
  late AnimationController _likeController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: _duration.inMilliseconds ~/ 2),
    );
    _heartScale = Tween<double>(begin: 1.0, end: 1.2).animate(_likeController);
  }

  @override
  void didUpdateWidget(covariant AnimatedLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startHeartAnimation();
    }
  }

  void startHeartAnimation() async {
    await _likeController.forward();
    await _likeController.reverse();
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _heartScale,
      child: widget.child,
    );
  }
}
