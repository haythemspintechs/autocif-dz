import 'package:flutter_test/flutter_test.dart';
import 'package:autocif_dz/core/constants/app_constants.dart';
import 'package:autocif_dz/features/calculator/domain/models/calculation_input.dart';
import 'package:autocif_dz/features/calculator/domain/usecases/calculate_customs.dart';

void main() {
  const engine = CalculateCustoms();

  group('Dépannage exclusion integration', () {
    test('AppConstants contract keeps depannage exclusion enabled', () {
      expect(AppConstants.excludeDepannageCosts, isTrue);
    });

    test('grand total reconciles only documented components', () {
      const input = CalculationInput(
        fobPriceUsd: 15000,
        oceanFreightUsd: 1500,
        engineCc: 2000,
        exchangeRateDzd: 135,
        portDays: 10,
      );

      final result = engine.execute(input);

      final reconciled =
          result.cifDzd +
          result.totalCustomsTaxesDzd +
          result.portHandlingStorageDzd +
          result.brokerAndExpertFeesDzd;

      expect(result.grandTotalDzd, closeTo(reconciled, 0.01));
    });

    test('no hidden tow cost appears in low-engine scenario', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1200,
        exchangeRateDzd: 135,
        portDays: 5,
      );

      final result = engine.execute(input);

      final reconciled =
          result.cifDzd +
          result.totalCustomsTaxesDzd +
          result.portHandlingStorageDzd +
          result.brokerAndExpertFeesDzd;

      expect(result.grandTotalDzd, closeTo(reconciled, 0.01));
    });

    test('no hidden tow cost appears in electric scenario', () {
      const input = CalculationInput(
        fobPriceUsd: 18000,
        oceanFreightUsd: 1200,
        engineCc: 0,
        isElectric: true,
        exchangeRateDzd: 135,
        portDays: 7,
      );

      final result = engine.execute(input);

      final reconciled =
          result.cifDzd +
          result.totalCustomsTaxesDzd +
          result.portHandlingStorageDzd +
          result.brokerAndExpertFeesDzd;

      expect(result.grandTotalDzd, closeTo(reconciled, 0.01));
    });
  });
}
