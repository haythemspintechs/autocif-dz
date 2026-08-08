import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class PreferencesService {
  PreferencesService._();
  static final PreferencesService instance = PreferencesService._();

  static const _keyLocale = 'pref_locale';
  static const _keyThemeMode = 'pref_theme_mode';
  static const _keyBankRate = 'pref_bank_rate';
  static const _keySquareRate = 'pref_square_rate';
  static const _keyInterstitialCounter = 'pref_interstitial_counter';

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveLocale(String localeCode) async {
    await init();
    await _prefs!.setString(_keyLocale, localeCode);
  }

  String getLocale() =>
      _prefs?.getString(_keyLocale) ?? AppConstants.defaultLocale;

  Future<void> saveThemeMode(ThemeMode mode) async {
    await init();
    await _prefs!.setString(_keyThemeMode, mode.name);
  }

  ThemeMode getThemeMode() {
    switch (_prefs?.getString(_keyThemeMode)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveBankRate(double rate) async {
    await init();
    await _prefs!.setDouble(_keyBankRate, rate);
  }

  double getBankRate() =>
      _prefs?.getDouble(_keyBankRate) ?? AppConstants.defaultBankExchangeRate;

  Future<void> saveSquareRate(double rate) async {
    await init();
    await _prefs!.setDouble(_keySquareRate, rate);
  }

  double getSquareRate() =>
      _prefs?.getDouble(_keySquareRate) ??
      AppConstants.defaultSquareExchangeRate;

  // Interstitial counter — session-based by default (not restored on init).
  int _sessionInterstitialCount = 0;

  int getInterstitialCount() => _sessionInterstitialCount;
  void incrementInterstitialCount() => _sessionInterstitialCount++;

  /// Opt-in: call this if you later want the counter to survive app restarts.
  Future<void> persistCounter() async {
    await init();
    await _prefs!.setInt(_keyInterstitialCounter, _sessionInterstitialCount);
  }

  Future<void> restoreCounterFromDisk() async {
    await init();
    _sessionInterstitialCount = _prefs!.getInt(_keyInterstitialCounter) ?? 0;
  }

  Future<void> clearAll() async {
    await init();
    await _prefs!.clear();
  }
}
