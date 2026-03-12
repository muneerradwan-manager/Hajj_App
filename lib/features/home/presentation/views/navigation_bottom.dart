import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_routes.dart';
import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';
import 'package:bawabatelhajj/shared/widgets/exit_app_dialog.dart';

import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/gradient_elevated_button.dart';
import '../widgets/send_help_dialog.dart';
import 'home_view.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  static const List<_NavItemData> _navItems = [
    _NavItemData(labelKey: 'nav.home', icon: LucideIcons.house),
    _NavItemData(labelKey: 'nav.training', icon: LucideIcons.graduationCap),
    _NavItemData(labelKey: 'nav.help', icon: LucideIcons.info),
    _NavItemData(labelKey: 'nav.support', icon: LucideIcons.phone),
    _NavItemData(labelKey: 'nav.more', icon: LucideIcons.menu),
  ];

  static final List<Widget> _pages = const [
    HomeView(),
    _PlaceholderPage(titleKey: 'nav.training'),
    _PlaceholderPage(titleKey: 'nav.help'),
    _PlaceholderPage(titleKey: 'nav.support'),
    MoreView(),
  ];

  late final PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<MeCubit>().loadMe();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (_selectedIndex == index) return;
    final previousIndex = _selectedIndex;
    setState(() => _selectedIndex = index);

    final isAdjacent = (previousIndex - index).abs() == 1;
    if (isAdjacent) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    _pageController.jumpToPage(index);
  }

  Future<void> _handleExitRequest() async {
    final shouldExit = await showExitAppDialog(context);
    if (!mounted || !shouldExit) return;
    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocListener<MeCubit, MeState>(
      listenWhen: (previous, current) =>
          !previous.isUnauthorized && current.isUnauthorized,
      listener: (context, state) {
        context.read<MeCubit>().clearState();
        context.go(AppRoutes.loginPath);
      },
      child: PopScope(
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
          bottomNavigationBar: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none, // Allows the button to overflow the top
            children: [
              // 1. The Actual Navigation Bar
              DecoratedBox(
                decoration: BoxDecoration(
                  color: cs.surface,
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
                        // Create an empty "hole" in the middle of the Row
                        if (index == 2) {
                          return const Expanded(child: SizedBox.shrink());
                        }

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

              // 2. The Overlapping Button (30% above the top)
              Positioned(
                top: -15,
                child: GestureDetector(
                  onTap: () => showSendHelpDialog(context),
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: cs.brandRed,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: cs.brandRed.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          LucideIcons.info,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const CustomText(
                        'nav.help',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.red,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientElevatedButton(
            gradientColor: GradientColors.red,
            onPressed: () async {
              await getIt<LoginCubit>().logout();
              if (context.mounted) {
                context.read<MeCubit>().clearState();
              }
              if (context.mounted) context.go(AppRoutes.loginPath);
            },
            child: const CustomText('nav.logout', color: CustomTextColor.white),
          ),
        ],
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
    final cs = Theme.of(context).colorScheme;
    final activeColor = cs.primary;
    final inactiveColor = cs.brandGold;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor
                  : cs.outline.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.white : inactiveColor,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            labelKey.tr(context),
            type: CustomTextType.labelSmall,
            color: isSelected ? CustomTextColor.green : CustomTextColor.gold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
      child: CustomText(
        titleKey.tr(context),
        style: theme.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
