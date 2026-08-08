import 'package:equatable/equatable.dart';

/// Full breakdown of the customs/import cost cascade.
/// NOTE: Deliberately contains NO field for tow truck / dépannage costs.
/// This is an intentional scope exclusion — see AppConstants.excludeDepannageCosts.
class CalculationResult extends Equatable {
  final double cifUsd;
  final double cifDzd;
  final double dutyRateApplied; // 0.06, 0.15, or 0.24
  final double customsDutyDzd;
  final double solidarityTaxDzd;
  final double vatDzd;
  final double fixedRpsDzd;
  final double totalCustomsTaxesDzd;
  final double portHandlingStorageDzd;
  final double brokerAndExpertFeesDzd;
  final double grandTotalDzd;
  final double grandTotalMillionCentimes;

  const CalculationResult({
    required this.cifUsd,
    required this.cifDzd,
    required this.dutyRateApplied,
    required this.customsDutyDzd,
    required this.solidarityTaxDzd,
    required this.vatDzd,
    required this.fixedRpsDzd,
    required this.totalCustomsTaxesDzd,
    required this.portHandlingStorageDzd,
    required this.brokerAndExpertFeesDzd,
    required this.grandTotalDzd,
    required this.grandTotalMillionCentimes,
  });

  static const empty = CalculationResult(
    cifUsd: 0,
    cifDzd: 0,
    dutyRateApplied: 0,
    customsDutyDzd: 0,
    solidarityTaxDzd: 0,
    vatDzd: 0,
    fixedRpsDzd: 0,
    totalCustomsTaxesDzd: 0,
    portHandlingStorageDzd: 0,
    brokerAndExpertFeesDzd: 0,
    grandTotalDzd: 0,
    grandTotalMillionCentimes: 0,
  );

  @override
  List<Object?> get props => [
        cifUsd,
        cifDzd,
        dutyRateApplied,
        customsDutyDzd,
        solidarityTaxDzd,
        vatDzd,
        fixedRpsDzd,
        totalCustomsTaxesDzd,
        portHandlingStorageDzd,
        brokerAndExpertFeesDzd,
        grandTotalDzd,
        grandTotalMillionCentimes,
      ];
}