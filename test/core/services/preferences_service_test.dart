import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autocif_dz/core/constants/app_constants.dart';
import 'package:autocif_dz/core/services/preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.instance.init();
    await PreferencesService.instance.restoreCounterFromDisk();
  });

  group('PreferencesService', () {
    test('returns default values before any save', () {
      final prefs = PreferencesService.instance;

      expect(prefs.getLocale(), AppConstants.defaultLocale);
      expect(prefs.getThemeMode(), ThemeMode.system);
      expect(prefs.getBankRate(), AppConstants.defaultBankExchangeRate);
      expect(prefs.getSquareRate(), AppConstants.defaultSquareExchangeRate);
      expect(prefs.getInterstitialCount(), 0);
    });

    test('saves and restores locale', () async {
      final prefs = PreferencesService.instance;

      await prefs.saveLocale('fr');

      expect(prefs.getLocale(), 'fr');
    });

    test('saves and restores theme mode', () async {
      final prefs = PreferencesService.instance;

      await prefs.saveThemeMode(ThemeMode.dark);
      expect(prefs.getThemeMode(), ThemeMode.dark);

      await prefs.saveThemeMode(ThemeMode.light);
      expect(prefs.getThemeMode(), ThemeMode.light);
    });

    test('saves and restores custom exchange rates', () async {
      final prefs = PreferencesService.instance;

      await prefs.saveBankRate(140.0);
      await prefs.saveSquareRate(250.0);

      expect(prefs.getBankRate(), 140.0);
      expect(prefs.getSquareRate(), 250.0);
    });

    test('increments session interstitial counter in memory', () async {
      final prefs = PreferencesService.instance;

      await prefs.restoreCounterFromDisk();
      expect(prefs.getInterstitialCount(), 0);

      prefs.incrementInterstitialCount();
      prefs.incrementInterstitialCount();

      expect(prefs.getInterstitialCount(), 2);
    });

    test('persists and restores interstitial counter when opted in', () async {
      final prefs = PreferencesService.instance;

      await prefs.restoreCounterFromDisk();
      expect(prefs.getInterstitialCount(), 0);

      prefs.incrementInterstitialCount();
      prefs.incrementInterstitialCount();
      await prefs.persistCounter();

      await prefs.restoreCounterFromDisk();

      expect(prefs.getInterstitialCount(), 2);
    });

    test('clearAll removes persisted values', () async {
      final prefs = PreferencesService.instance;

      await prefs.saveLocale('ar');
      await prefs.saveThemeMode(ThemeMode.dark);
      await prefs.saveBankRate(150.0);
      await prefs.saveSquareRate(260.0);

      prefs.incrementInterstitialCount();
      await prefs.persistCounter();

      await prefs.clearAll();
      await prefs.restoreCounterFromDisk();

      expect(prefs.getLocale(), AppConstants.defaultLocale);
      expect(prefs.getThemeMode(), ThemeMode.system);
      expect(prefs.getBankRate(), AppConstants.defaultBankExchangeRate);
      expect(prefs.getSquareRate(), AppConstants.defaultSquareExchangeRate);
      expect(prefs.getInterstitialCount(), 0);
    });
  });
}
