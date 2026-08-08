import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../checklist/presentation/screens/checklist_screen.dart';
import 'calculator_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final void Function(Locale) onLocaleChanged;
  final void Function(ThemeMode) onThemeModeChanged;

  const MainNavigationScreen({
    super.key,
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final screens = [
      const CalculatorScreen(),
      const ChecklistScreen(),
      SettingsScreen(
        onLocaleChanged: widget.onLocaleChanged,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        indicatorColor: AppColors.primaryEmerald.withValues(alpha: 0.15),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.calculate_outlined),
            selectedIcon: const Icon(
              Icons.calculate,
              color: AppColors.primaryEmerald,
            ),
            label: l10n.navCalculator,
          ),
          NavigationDestination(
            icon: const Icon(Icons.checklist_outlined),
            selectedIcon: const Icon(
              Icons.checklist,
              color: AppColors.primaryEmerald,
            ),
            label: l10n.navChecklist,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(
              Icons.settings,
              color: AppColors.primaryEmerald,
            ),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
