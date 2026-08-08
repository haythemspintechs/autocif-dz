import '../../../../core/constants/app_constants.dart';
import '../models/calculation_input.dart';
import '../models/calculation_result.dart';

/// Pure Dart, side-effect-free customs calculation engine.
/// Implements the Article 110 tier cascade: FOB -> CIF -> DD -> CS -> TVA -> RPS
/// followed by port/admin/broker expense estimation.
///
/// IMPORTANT: This engine NEVER includes tow truck / dépannage costs.
/// Any modification here must preserve that exclusion (AppConstants.excludeDepannageCosts).
class CalculateCustoms {
  const CalculateCustoms();

  static const double _portHandlingBaseDzd = 45000.0;
  static const double _portHandlingPerDayDzd = 1500.0;
  static const double _declarantFeeDzd = 50000.0;
  static const double _inspectionAndGrayCardFeeDzd = 30000.0;

  CalculationResult execute(CalculationInput input) {
    assert(
      AppConstants.excludeDepannageCosts,
      'Dépannage costs must remain excluded from the calculation engine.',
    );

    final double cifUsd = input.fobPriceUsd +
        input.oceanFreightUsd +
        (input.fobPriceUsd * input.marineInsuranceRate);

    final double effectiveRate =
        input.useParallelMarket ? input.parallelMarketRateDzd : input.exchangeRateDzd;

    final double cifDzd = cifUsd * effectiveRate;

    final double dutyRate = _resolveDutyRate(
      isElectric: input.isElectric,
      engineCc: input.engineCc,
    );

    final double customsDutyDzd = cifDzd * dutyRate;
    final double solidarityTaxDzd = cifDzd * AppConstants.solidarityTaxRate;
    final double vatDzd =
        (cifDzd + customsDutyDzd + solidarityTaxDzd) * AppConstants.vatRate;
    const double fixedRpsDzd = AppConstants.fixedRps;

    final double totalCustomsTaxesDzd =
        customsDutyDzd + solidarityTaxDzd + vatDzd + fixedRpsDzd;

    final double portHandlingStorageDzd =
        _portHandlingBaseDzd + (input.portDays * _portHandlingPerDayDzd);

    const double brokerAndExpertFeesDzd =
        _declarantFeeDzd + _inspectionAndGrayCardFeeDzd;

    final double grandTotalDzd = cifDzd +
        totalCustomsTaxesDzd +
        portHandlingStorageDzd +
        brokerAndExpertFeesDzd;

    final double grandTotalMillionCentimes =
        grandTotalDzd / AppConstants.dzdToMillionCentimes;

    return CalculationResult(
      cifUsd: cifUsd,
      cifDzd: cifDzd,
      dutyRateApplied: dutyRate,
      customsDutyDzd: customsDutyDzd,
      solidarityTaxDzd: solidarityTaxDzd,
      vatDzd: vatDzd,
      fixedRpsDzd: fixedRpsDzd,
      totalCustomsTaxesDzd: totalCustomsTaxesDzd,
      portHandlingStorageDzd: portHandlingStorageDzd,
      brokerAndExpertFeesDzd: brokerAndExpertFeesDzd,
      grandTotalDzd: grandTotalDzd,
      grandTotalMillionCentimes: grandTotalMillionCentimes,
    );
  }

  /// Article 110 tier resolution.
  double _resolveDutyRate({required bool isElectric, required int engineCc}) {
    if (isElectric || engineCc <= AppConstants.cylinderCapTierLow) {
      return AppConstants.dutyRateTierLow; // 6%
    } else if (engineCc <= AppConstants.cylinderCapTierMid) {
      return AppConstants.dutyRateTierMid; // 15%
    } else {
      return AppConstants.dutyRateTierHigh; // 24%
    }
  }
}