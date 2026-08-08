import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';

/// Immutable snapshot of all user-adjustable calculator inputs.
class CalculationInput extends Equatable {
  final double fobPriceUsd;
  final double oceanFreightUsd;
  final double marineInsuranceRate; // e.g. 0.015 = 1.5% of FOB
  final int engineCc;
  final bool isElectric;
  final double exchangeRateDzd; // official bank rate
  final bool useParallelMarket;
  final double parallelMarketRateDzd; // "Square" rate
  final int portDays;

  const CalculationInput({
    this.fobPriceUsd = 0,
    this.oceanFreightUsd = 0,
    this.marineInsuranceRate = 0.015,
    this.engineCc = 1200,
    this.isElectric = false,
    this.exchangeRateDzd = AppConstants.defaultBankExchangeRate,
    this.useParallelMarket = false,
    this.parallelMarketRateDzd = AppConstants.defaultSquareExchangeRate,
    this.portDays = 15,
  });

  CalculationInput copyWith({
    double? fobPriceUsd,
    double? oceanFreightUsd,
    double? marineInsuranceRate,
    int? engineCc,
    bool? isElectric,
    double? exchangeRateDzd,
    bool? useParallelMarket,
    double? parallelMarketRateDzd,
    int? portDays,
  }) {
    return CalculationInput(
      fobPriceUsd: fobPriceUsd ?? this.fobPriceUsd,
      oceanFreightUsd: oceanFreightUsd ?? this.oceanFreightUsd,
      marineInsuranceRate: marineInsuranceRate ?? this.marineInsuranceRate,
      engineCc: engineCc ?? this.engineCc,
      isElectric: isElectric ?? this.isElectric,
      exchangeRateDzd: exchangeRateDzd ?? this.exchangeRateDzd,
      useParallelMarket: useParallelMarket ?? this.useParallelMarket,
      parallelMarketRateDzd: parallelMarketRateDzd ?? this.parallelMarketRateDzd,
      portDays: portDays ?? this.portDays,
    );
  }

  @override
  List<Object?> get props => [
        fobPriceUsd,
        oceanFreightUsd,
        marineInsuranceRate,
        engineCc,
        isElectric,
        exchangeRateDzd,
        useParallelMarket,
        parallelMarketRateDzd,
        portDays,
      ];
}