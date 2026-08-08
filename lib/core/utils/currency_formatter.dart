import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Handles DZD and "Million Centimes" formatting across AR/FR/EN locales.
class CurrencyFormatter {
  CurrencyFormatter._();

  static String formatDzd(double value, {required String localeCode}) {
    final formatter = NumberFormat.decimalPattern(localeCode);
    return '${formatter.format(value.round())} ${_dzdSuffix(localeCode)}';
  }

  static String formatMillionCentimes(double dzdValue, {required String localeCode}) {
    final millionCentimes = dzdValue / AppConstants.dzdToMillionCentimes;
    final formatter = NumberFormat('#,##0.00', localeCode);
    return '${formatter.format(millionCentimes)} ${_centimesSuffix(localeCode)}';
  }

  static String _dzdSuffix(String localeCode) {
    switch (localeCode) {
      case 'ar':
        return 'دج';
      case 'fr':
        return 'DZD';
      default:
        return 'DZD';
    }
  }

  static String _centimesSuffix(String localeCode) {
    switch (localeCode) {
      case 'ar':
        return 'مليون سنتيم';
      case 'fr':
        return 'Million CTM';
      default:
        return 'Million Centimes';
    }
  }
}