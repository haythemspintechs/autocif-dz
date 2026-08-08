import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/services/preferences_service.dart';

/// Settings: locale switch, theme toggle, and custom exchange rate
/// overrides. Callbacks bubble up to the app root via constructor
/// params (wired in main.dart in Step 1/5).
class SettingsScreen extends StatefulWidget {
  final void Function(Locale)? onLocaleChanged;
  final void Function(ThemeMode)? onThemeModeChanged;

  const SettingsScreen({
    super.key,
    this.onLocaleChanged,
    this.onThemeModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _bankRateController;
  late TextEditingController _squareRateController;
  ThemeMode _themeMode = ThemeMode.system;
  String _localeCode = 'ar';

  @override
  void initState() {
    super.initState();
    final prefs = PreferencesService.instance;
    _bankRateController = TextEditingController(
      text: prefs.getBankRate().toStringAsFixed(1),
    );
    _squareRateController = TextEditingController(
      text: prefs.getSquareRate().toStringAsFixed(1),
    );
    _themeMode = prefs.getThemeMode();
    _localeCode = prefs.getLocale();
  }

  @override
  void dispose() {
    _bankRateController.dispose();
    _squareRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.settingsLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'ar', label: Text('العربية')),
              ButtonSegment(value: 'fr', label: Text('Français')),
              ButtonSegment(value: 'en', label: Text('English')),
            ],
            selected: {_localeCode},
            onSelectionChanged: (selection) async {
              final code = selection.first;
              setState(() => _localeCode = code);
              await PreferencesService.instance.saveLocale(code);
              widget.onLocaleChanged?.call(Locale(code));
            },
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppColors.primaryEmerald,
              selectedForegroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          Text(
            l10n.settingsTheme,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.settingsThemeLight),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.settingsThemeDark),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.settingsThemeSystem),
              ),
            ],
            selected: {_themeMode},
            onSelectionChanged: (selection) async {
              final mode = selection.first;
              setState(() => _themeMode = mode);
              await PreferencesService.instance.saveThemeMode(mode);
              widget.onThemeModeChanged?.call(mode);
            },
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppColors.primaryEmerald,
              selectedForegroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Custom Exchange Rates',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _bankRateController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.exchangeRateOfficial,
              suffixText: 'DZD',
            ),
            onChanged: (v) {
              final rate = double.tryParse(v);
              if (rate != null) PreferencesService.instance.saveBankRate(rate);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _squareRateController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.exchangeRateSquare,
              suffixText: 'DZD',
            ),
            onChanged: (v) {
              final rate = double.tryParse(v);
              if (rate != null) {
                PreferencesService.instance.saveSquareRate(rate);
              }
            },
          ),
        ],
      ),
    );
  }
}
