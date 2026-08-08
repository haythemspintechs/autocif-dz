// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'AutoCif DZ';

  @override
  String get appSubtitle => 'Calculateur de Coût d\'Importation Automobile';

  @override
  String get navCalculator => 'Calculateur';

  @override
  String get navChecklist => 'Documents';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get inputSectionTitle => 'Détails du Véhicule et de l\'Achat';

  @override
  String get labelFobPrice => 'Prix FOB';

  @override
  String get labelFobPriceHint =>
      'Prix du véhicule au port d\'origine (avant expédition)';

  @override
  String get labelEngineType => 'Type de Moteur';

  @override
  String get engineTypeElectric => 'Électrique';

  @override
  String get engineTypeGasoline => 'Essence';

  @override
  String get engineTypeHybrid => 'Hybride';

  @override
  String get labelEngineCapacity => 'Cylindrée (cc)';

  @override
  String get labelOceanFreight => 'Fret Maritime';

  @override
  String get labelMarineInsurance => 'Assurance Maritime';

  @override
  String get labelExchangeRateMode => 'Mode de Taux de Change';

  @override
  String get exchangeRateOfficial => 'Taux Bancaire Officiel';

  @override
  String get exchangeRateSquare => 'Taux du Marché Parallèle (Square)';

  @override
  String get sectionTierTitle => 'Palier Douanier Applicable';

  @override
  String get tierLow => '≤ 1200cc ou Électrique — Droit de 6%';

  @override
  String get tierMid => '1201cc – 1800cc — Droit de 15%';

  @override
  String get tierHigh => '> 1800cc — Droit de 24%';

  @override
  String get breakdownTitle => 'Détail des Coûts';

  @override
  String get breakdownFob => 'Valeur FOB';

  @override
  String get breakdownFreight => 'Fret Maritime';

  @override
  String get breakdownInsurance => 'Assurance Maritime';

  @override
  String get breakdownCif => 'Valeur CIF';

  @override
  String get breakdownCustomsDuty => 'Droit de Douane (Article 110)';

  @override
  String get breakdownSolidarityTax => 'Taxe de Solidarité (CS) — 3%';

  @override
  String get breakdownVat => 'TVA — 19%';

  @override
  String get breakdownRps => 'Redevance Fixe (RPS)';

  @override
  String get breakdownBrokerFee => 'Frais de Transitaire';

  @override
  String get breakdownExpertInspection => 'Frais d\'Expertise';

  @override
  String get breakdownGrayCard => 'Frais de Carte Grise';

  @override
  String get breakdownTotal => 'Coût Total Estimé';

  @override
  String get currencyDzd => 'DZD';

  @override
  String get currencyMillionCentimes => 'Million de Centimes';

  @override
  String get depannageDisclaimer =>
      'Remarque : Cette estimation exclut les frais de dépannage / remorquage, car ils varient fortement selon la ville et la wilaya.';

  @override
  String get buttonCalculate => 'Calculer';

  @override
  String get buttonShareResult => 'Partager le Résultat';

  @override
  String get buttonReset => 'Réinitialiser';

  @override
  String get checklistTitle => 'Liste des Documents d\'Importation';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeSystem => 'Système';
}
