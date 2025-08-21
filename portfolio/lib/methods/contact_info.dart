import 'package:flutter/material.dart';

class ContactInfo extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ContactInfo({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _isHovered
                      ? theme.colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                  border: _isHovered
                      ? Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? theme.colorScheme.primary.withOpacity(0.2)
                            : theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.icon,
                        color: _isHovered
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _isHovered
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withOpacity(0.8),
                          fontWeight:
                              _isHovered ? FontWeight.w500 : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.onTap != null) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: _isHovered
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.5),
                        size: 12,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
