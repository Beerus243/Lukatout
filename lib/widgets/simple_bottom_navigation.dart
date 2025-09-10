import 'package:flutter/material.dart';

class SimpleBottomNavigation extends StatelessWidget {
  final List<IconData> icons;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color navBg;
  final double borderRadius;
  final Color activeBadgeColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;

  final double iconSize = 24;
  final double iconSizeSelected = 28;
  final double centerIconSize = 32;
  final double centerIconSizeSelected = 36;
  final double badgeSize = 70; // augmenté
  final double badgeSizeUnselected = 48; // augmenté
  final double centerSize = 64;
  final double centerSizeSelected = 70;

  const SimpleBottomNavigation({
    super.key,
    required this.icons,
    required this.currentIndex,
    required this.onTap,
    this.navBg = const Color(0xFF020822),
    this.borderRadius = 20.0,
    this.activeBadgeColor = const Color(0xFF36A7FF),
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white70,
  }) : assert(icons.length == 5);


  Widget _navItem({required IconData icon, required int index}) {
    final bool selected = index == currentIndex;
    final double size = selected ? iconSizeSelected : iconSize;
    final double boxSize = selected ? badgeSize : badgeSizeUnselected;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: boxSize,
            height: boxSize,
            decoration: selected
                ? BoxDecoration(
                    color: activeBadgeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: activeBadgeColor.withOpacity(0.14),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  )
                : null,
            child: Icon(
              icon,
              size: size,
              color: selected ? selectedIconColor : unselectedIconColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _centerItem({required IconData icon}) {
    final bool selected = currentIndex == 2;
    final double cSize = selected ? centerSizeSelected : centerSize;
    final double iSize = selected ? centerIconSizeSelected : centerIconSize;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: cSize,
            height: cSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: iSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = icons;
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: navBg,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: Row(
          children: [
            _navItem(icon: p[0], index: 0),
            _navItem(icon: p[1], index: 1),
            _centerItem(icon: p[2]),
            _navItem(icon: p[3], index: 3),
            _navItem(icon: p[4], index: 4),
          ],
        ),
      ),
    );
  }
}