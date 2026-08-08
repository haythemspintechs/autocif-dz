// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AutoCif DZ';

  @override
  String get appSubtitle => 'Car Import Cost Calculator';

  @override
  String get navCalculator => 'Calculator';

  @override
  String get navChecklist => 'Checklist';

  @override
  String get navSettings => 'Settings';

  @override
  String get inputSectionTitle => 'Vehicle & Purchase Details';

  @override
  String get labelFobPrice => 'FOB Price';

  @override
  String get labelFobPriceHint =>
      'Vehicle price at origin port (before shipping)';

  @override
  String get labelEngineType => 'Engine Type';

  @override
  String get engineTypeElectric => 'Electric';

  @override
  String get engineTypeGasoline => 'Gasoline';

  @override
  String get engineTypeHybrid => 'Hybrid';

  @override
  String get labelEngineCapacity => 'Engine Capacity (cc)';

  @override
  String get labelOceanFreight => 'Ocean Freight';

  @override
  String get labelMarineInsurance => 'Marine Insurance';

  @override
  String get labelExchangeRateMode => 'Exchange Rate Mode';

  @override
  String get exchangeRateOfficial => 'Official Bank Rate';

  @override
  String get exchangeRateSquare => 'Parallel Market Rate (Square)';

  @override
  String get sectionTierTitle => 'Applicable Customs Tier';

  @override
  String get tierLow => '≤ 1200cc or Electric — 6% Duty';

  @override
  String get tierMid => '1201cc – 1800cc — 15% Duty';

  @override
  String get tierHigh => '> 1800cc — 24% Duty';

  @override
  String get breakdownTitle => 'Cost Breakdown';

  @override
  String get breakdownFob => 'FOB Value';

  @override
  String get breakdownFreight => 'Ocean Freight';

  @override
  String get breakdownInsurance => 'Marine Insurance';

  @override
  String get breakdownCif => 'CIF Value';

  @override
  String get breakdownCustomsDuty => 'Customs Duty (Article 110)';

  @override
  String get breakdownSolidarityTax => 'Solidarity Tax (CS) — 3%';

  @override
  String get breakdownVat => 'VAT (TVA) — 19%';

  @override
  String get breakdownRps => 'Fixed Service Fee (RPS)';

  @override
  String get breakdownBrokerFee => 'Customs Broker Fee';

  @override
  String get breakdownExpertInspection => 'Expert Inspection Fee';

  @override
  String get breakdownGrayCard => 'Gray Card Processing';

  @override
  String get breakdownTotal => 'Estimated Total Cost';

  @override
  String get currencyDzd => 'DZD';

  @override
  String get currencyMillionCentimes => 'Million Centimes';

  @override
  String get depannageDisclaimer =>
      'Note: This estimate excludes tow truck / breakdown transport (Dépannage) costs, as these vary significantly by city and wilaya.';

  @override
  String get buttonCalculate => 'Calculate';

  @override
  String get buttonShareResult => 'Share Result';

  @override
  String get buttonReset => 'Reset';

  @override
  String get checklistTitle => 'Import Document Checklist';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System Default';
}
