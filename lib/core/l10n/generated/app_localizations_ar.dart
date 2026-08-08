// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أوتوسيف DZ';

  @override
  String get appSubtitle => 'حاسبة تكلفة استيراد السيارات';

  @override
  String get navCalculator => 'الحاسبة';

  @override
  String get navChecklist => 'قائمة الوثائق';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get inputSectionTitle => 'تفاصيل السيارة والشراء';

  @override
  String get labelFobPrice => 'سعر FOB';

  @override
  String get labelFobPriceHint => 'سعر السيارة في ميناء المنشأ (قبل الشحن)';

  @override
  String get labelEngineType => 'نوع المحرك';

  @override
  String get engineTypeElectric => 'كهربائية';

  @override
  String get engineTypeGasoline => 'بنزين';

  @override
  String get engineTypeHybrid => 'هجين';

  @override
  String get labelEngineCapacity => 'سعة المحرك (سم مكعب)';

  @override
  String get labelOceanFreight => 'الشحن البحري';

  @override
  String get labelMarineInsurance => 'التأمين البحري';

  @override
  String get labelExchangeRateMode => 'وضع سعر الصرف';

  @override
  String get exchangeRateOfficial => 'السعر البنكي الرسمي';

  @override
  String get exchangeRateSquare => 'سعر السوق الموازي (السكوار)';

  @override
  String get sectionTierTitle => 'الشريحة الجمركية المطبقة';

  @override
  String get tierLow => 'أقل أو يساوي 1200 سم³ أو كهربائية — رسم 6٪';

  @override
  String get tierMid => '1201 – 1800 سم³ — رسم 15٪';

  @override
  String get tierHigh => 'أكثر من 1800 سم³ — رسم 24٪';

  @override
  String get breakdownTitle => 'تفصيل التكاليف';

  @override
  String get breakdownFob => 'قيمة FOB';

  @override
  String get breakdownFreight => 'الشحن البحري';

  @override
  String get breakdownInsurance => 'التأمين البحري';

  @override
  String get breakdownCif => 'قيمة CIF';

  @override
  String get breakdownCustomsDuty => 'الرسم الجمركي (المادة 110)';

  @override
  String get breakdownSolidarityTax => 'رسم التضامن (CS) — 3٪';

  @override
  String get breakdownVat => 'الرسم على القيمة المضافة (TVA) — 19٪';

  @override
  String get breakdownRps => 'الرسم الثابت للخدمة (RPS)';

  @override
  String get breakdownBrokerFee => 'أتعاب وسيط الجمارك';

  @override
  String get breakdownExpertInspection => 'رسم الخبرة الفنية';

  @override
  String get breakdownGrayCard => 'رسم استخراج البطاقة الرمادية';

  @override
  String get breakdownTotal => 'التكلفة الإجمالية التقديرية';

  @override
  String get currencyDzd => 'دج';

  @override
  String get currencyMillionCentimes => 'مليون سنتيم';

  @override
  String get depannageDisclaimer =>
      'ملاحظة: هذا التقدير لا يشمل مصاريف سطحة السحب / الدعم لأنها تختلف بشكل كبير حسب المدينة والولاية.';

  @override
  String get buttonCalculate => 'احسب';

  @override
  String get buttonShareResult => 'مشاركة النتيجة';

  @override
  String get buttonReset => 'إعادة تعيين';

  @override
  String get checklistTitle => 'قائمة وثائق الاستيراد';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'غامق';

  @override
  String get settingsThemeSystem => 'افتراضي النظام';
}
