import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AutoCif DZ'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Car Import Cost Calculator'**
  String get appSubtitle;

  /// No description provided for @navCalculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get navCalculator;

  /// No description provided for @navChecklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get navChecklist;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @inputSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle & Purchase Details'**
  String get inputSectionTitle;

  /// No description provided for @labelFobPrice.
  ///
  /// In en, this message translates to:
  /// **'FOB Price'**
  String get labelFobPrice;

  /// No description provided for @labelFobPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Vehicle price at origin port (before shipping)'**
  String get labelFobPriceHint;

  /// No description provided for @labelEngineType.
  ///
  /// In en, this message translates to:
  /// **'Engine Type'**
  String get labelEngineType;

  /// No description provided for @engineTypeElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get engineTypeElectric;

  /// No description provided for @engineTypeGasoline.
  ///
  /// In en, this message translates to:
  /// **'Gasoline'**
  String get engineTypeGasoline;

  /// No description provided for @engineTypeHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get engineTypeHybrid;

  /// No description provided for @labelEngineCapacity.
  ///
  /// In en, this message translates to:
  /// **'Engine Capacity (cc)'**
  String get labelEngineCapacity;

  /// No description provided for @labelOceanFreight.
  ///
  /// In en, this message translates to:
  /// **'Ocean Freight'**
  String get labelOceanFreight;

  /// No description provided for @labelMarineInsurance.
  ///
  /// In en, this message translates to:
  /// **'Marine Insurance'**
  String get labelMarineInsurance;

  /// No description provided for @labelExchangeRateMode.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate Mode'**
  String get labelExchangeRateMode;

  /// No description provided for @exchangeRateOfficial.
  ///
  /// In en, this message translates to:
  /// **'Official Bank Rate'**
  String get exchangeRateOfficial;

  /// No description provided for @exchangeRateSquare.
  ///
  /// In en, this message translates to:
  /// **'Parallel Market Rate (Square)'**
  String get exchangeRateSquare;

  /// No description provided for @sectionTierTitle.
  ///
  /// In en, this message translates to:
  /// **'Applicable Customs Tier'**
  String get sectionTierTitle;

  /// No description provided for @tierLow.
  ///
  /// In en, this message translates to:
  /// **'≤ 1200cc or Electric — 6% Duty'**
  String get tierLow;

  /// No description provided for @tierMid.
  ///
  /// In en, this message translates to:
  /// **'1201cc – 1800cc — 15% Duty'**
  String get tierMid;

  /// No description provided for @tierHigh.
  ///
  /// In en, this message translates to:
  /// **'> 1800cc — 24% Duty'**
  String get tierHigh;

  /// No description provided for @breakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Cost Breakdown'**
  String get breakdownTitle;

  /// No description provided for @breakdownFob.
  ///
  /// In en, this message translates to:
  /// **'FOB Value'**
  String get breakdownFob;

  /// No description provided for @breakdownFreight.
  ///
  /// In en, this message translates to:
  /// **'Ocean Freight'**
  String get breakdownFreight;

  /// No description provided for @breakdownInsurance.
  ///
  /// In en, this message translates to:
  /// **'Marine Insurance'**
  String get breakdownInsurance;

  /// No description provided for @breakdownCif.
  ///
  /// In en, this message translates to:
  /// **'CIF Value'**
  String get breakdownCif;

  /// No description provided for @breakdownCustomsDuty.
  ///
  /// In en, this message translates to:
  /// **'Customs Duty (Article 110)'**
  String get breakdownCustomsDuty;

  /// No description provided for @breakdownSolidarityTax.
  ///
  /// In en, this message translates to:
  /// **'Solidarity Tax (CS) — 3%'**
  String get breakdownSolidarityTax;

  /// No description provided for @breakdownVat.
  ///
  /// In en, this message translates to:
  /// **'VAT (TVA) — 19%'**
  String get breakdownVat;

  /// No description provided for @breakdownRps.
  ///
  /// In en, this message translates to:
  /// **'Fixed Service Fee (RPS)'**
  String get breakdownRps;

  /// No description provided for @breakdownBrokerFee.
  ///
  /// In en, this message translates to:
  /// **'Customs Broker Fee'**
  String get breakdownBrokerFee;

  /// No description provided for @breakdownExpertInspection.
  ///
  /// In en, this message translates to:
  /// **'Expert Inspection Fee'**
  String get breakdownExpertInspection;

  /// No description provided for @breakdownGrayCard.
  ///
  /// In en, this message translates to:
  /// **'Gray Card Processing'**
  String get breakdownGrayCard;

  /// No description provided for @breakdownTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated Total Cost'**
  String get breakdownTotal;

  /// No description provided for @currencyDzd.
  ///
  /// In en, this message translates to:
  /// **'DZD'**
  String get currencyDzd;

  /// No description provided for @currencyMillionCentimes.
  ///
  /// In en, this message translates to:
  /// **'Million Centimes'**
  String get currencyMillionCentimes;

  /// No description provided for @depannageDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Note: This estimate excludes tow truck / breakdown transport (Dépannage) costs, as these vary significantly by city and wilaya.'**
  String get depannageDisclaimer;

  /// No description provided for @buttonCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get buttonCalculate;

  /// No description provided for @buttonShareResult.
  ///
  /// In en, this message translates to:
  /// **'Share Result'**
  String get buttonShareResult;

  /// No description provided for @buttonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get buttonReset;

  /// No description provided for @checklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Document Checklist'**
  String get checklistTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settingsThemeSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
