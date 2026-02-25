import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/shared/widgets/exit_app_dialog.dart';

import 'home_view.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  static const List<_NavItemData> _navItems = [
    _NavItemData(labelKey: 'nav.home', icon: LucideIcons.house),
    _NavItemData(labelKey: 'nav.training', icon: LucideIcons.bookOpen),
    _NavItemData(labelKey: 'nav.support', icon: LucideIcons.messageCircle),
    _NavItemData(labelKey: 'nav.more', icon: LucideIcons.menu),
  ];

  static const List<Widget> _pages = [
    HomeView(),
    _PlaceholderPage(titleKey: 'nav.training'),
    _PlaceholderPage(titleKey: 'nav.support'),
    _PlaceholderPage(titleKey: 'nav.more'),
  ];

  late final PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _handleExitRequest() async {
    final shouldExit = await showExitAppDialog(context);
    if (!mounted || !shouldExit) return;
    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleExitRequest();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (_selectedIndex == index) return;
            setState(() => _selectedIndex = index);
          },
          children: _pages,
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Row(
                children: List.generate(_navItems.length, (index) {
                  final item = _navItems[index];
                  return Expanded(
                    child: _BottomNavItem(
                      labelKey: item.labelKey,
                      icon: item.icon,
                      isSelected: index == _selectedIndex,
                      onTap: () => _onTabSelected(index),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String labelKey;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.labelKey,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.brandGold;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  style:
                      (theme.textTheme.labelSmall ?? const TextStyle())
                          .copyWith(
                    color: isSelected ? activeColor : inactiveColor,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(
                    labelKey.tr(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String labelKey;
  final IconData icon;

  const _NavItemData({required this.labelKey, required this.icon});
}

class _PlaceholderPage extends StatelessWidget {
  final String titleKey;

  const _PlaceholderPage({required this.titleKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Text(
        titleKey.tr(context),
        style: theme.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
