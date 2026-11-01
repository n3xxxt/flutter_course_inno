import 'package:flutter/material.dart';

/// Круглая кнопка лайка с анимацией нажатия.
class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
    this.size = 26,
    this.iconSize = 16,
  });

  final bool isLiked;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.35,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 50,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.35,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 50,
    ),
  ]).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return _LikeButtonView(
      scale: _scale,
      isLiked: widget.isLiked,
      onTap: _handleTap,
      size: widget.size,
      iconSize: widget.iconSize,
    );
  }
}

class _LikeButtonView extends StatelessWidget {
  const _LikeButtonView({
    required this.scale,
    required this.isLiked,
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  final Animation<double> scale;
  final bool isLiked;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: size,
            height: size,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isLiked),
                size: iconSize,
                color: isLiked
                    ? const Color(0xFFD9534F)
                    : const Color(0xFF555555),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
