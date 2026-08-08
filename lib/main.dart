import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/ads/ad_helper.dart';
import 'core/ads/interstitial_ad_manager.dart';
import 'core/l10n/generated/app_localizations.dart';
import 'core/services/preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'features/calculator/presentation/bloc/calculator_bloc.dart';
import 'features/calculator/presentation/bloc/calculator_event.dart';
import 'features/calculator/presentation/screens/main_navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.instance.init();
  runApp(const AutoCifApp());
}

class AutoCifApp extends StatefulWidget {
  const AutoCifApp({super.key});
  @override
  State<AutoCifApp> createState() => _AutoCifAppState();
}

class _AutoCifAppState extends State<AutoCifApp> {
  late Locale _locale;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    final prefs = PreferencesService.instance;
    _locale = Locale(prefs.getLocale());
    _themeMode = prefs.getThemeMode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdHelper.initialize();
      InterstitialAdManager.instance.preload();
    });
  }

  void _setLocale(Locale locale) => setState(() => _locale = locale);
  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    final isArabic = _locale.languageCode == 'ar';
    final prefs = PreferencesService.instance;

    return MaterialApp(
      title: 'AutoCif DZ',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light(isArabic: isArabic),
      darkTheme: AppTheme.dark(isArabic: isArabic),
      themeMode: _themeMode,
      home: BlocProvider<CalculatorBloc>(
        create: (_) => CalculatorBloc()
          ..add(OfficialRateChanged(prefs.getBankRate()))
          ..add(ParallelRateChanged(prefs.getSquareRate())),
        child: MainNavigationScreen(
          onLocaleChanged: _setLocale,
          onThemeModeChanged: _setThemeMode,
        ),
      ),
    );
  }
}
