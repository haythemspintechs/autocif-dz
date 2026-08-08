/// Core domain constants for AutoCif DZ.
/// All values sourced from Algerian Customs Code — Article 110,
/// and current Finance Law tax schedule. Update yearly as laws change.
class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------
  // ARTICLE 110 — CUSTOMS DUTY TIERS (applied on CIF value)
  // ---------------------------------------------------------------------
  /// Electric Vehicles & Gasoline/Hybrid <= 1200cc
  static const double dutyRateTierLow = 0.06; // 6%

  /// Gasoline/Hybrid 1201cc - 1800cc
  static const double dutyRateTierMid = 0.15; // 15%

  /// Gasoline/Hybrid > 1800cc
  static const double dutyRateTierHigh = 0.24; // 24%

  static const int cylinderCapTierLow = 1200; // cc
  static const int cylinderCapTierMid = 1800; // cc

  // ---------------------------------------------------------------------
  // TAX SCHEDULE
  // ---------------------------------------------------------------------
  /// Solidarity Tax (CS) — 3% of CIF value in DZD
  static const double solidarityTaxRate = 0.03;

  /// VAT (TVA) — 19% of (CIF + Customs Duty + CS)
  static const double vatRate = 0.19;

  /// Fixed RPS (Redevance de Prestation de Service) — flat fee, DZD
  static const double fixedRps = 2500.0;

  // ---------------------------------------------------------------------
  // DUAL CURRENCY ENGINE — DEFAULT RATES (user-editable at runtime)
  // ---------------------------------------------------------------------
  /// Official Banque d'Algérie rate (EUR -> DZD), fallback default.
  static const double defaultBankExchangeRate = 135.0;

  /// Parallel market ("Square" / السكوار) rate (EUR -> DZD), fallback default.
  static const double defaultSquareExchangeRate = 240.0;

  // ---------------------------------------------------------------------
  // UNIT CONVERSION
  // ---------------------------------------------------------------------
  /// 1 Million Centimes = 100,000 DZD
  static const double dzdToMillionCentimes = 10000.0;

  // ---------------------------------------------------------------------
  // SCOPE EXCLUSIONS
  // ---------------------------------------------------------------------
  /// IMPORTANT: Tow truck / breakdown transport (Dépannage) costs are
  /// STRICTLY EXCLUDED from all calculation formulas. This cost varies
  /// significantly per city/wilaya and must never be estimated or implied
  /// as included in any total. Always surface a disclaimer in the UI
  /// wherever a final total is displayed. See l10n key: `depannageDisclaimer`.
  static const bool excludeDepannageCosts = true;

  // ---------------------------------------------------------------------
  // MISC
  // ---------------------------------------------------------------------
  static const List<String> supportedLocales = ['ar', 'fr', 'en'];
  static const String defaultLocale = 'ar';
}