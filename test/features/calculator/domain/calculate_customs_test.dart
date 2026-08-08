import 'package:flutter_test/flutter_test.dart';
import 'package:autocif_dz/core/constants/app_constants.dart';
import 'package:autocif_dz/features/calculator/domain/models/calculation_input.dart';
import 'package:autocif_dz/features/calculator/domain/usecases/calculate_customs.dart';

void main() {
  const engine = CalculateCustoms();

  group('Article 110 duty tier resolution', () {
    test('applies 6% duty for electric vehicle regardless of cc', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 2000, // irrelevant when electric
        isElectric: true,
        exchangeRateDzd: 135,
        useParallelMarket: false,
      );
      final result = engine.execute(input);
      expect(result.dutyRateApplied, AppConstants.dutyRateTierLow);
      expect(result.dutyRateApplied, 0.06);
    });

    test('applies 6% duty for gasoline <= 1200cc', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1200,
        isElectric: false,
        exchangeRateDzd: 135,
      );
      final result = engine.execute(input);
      expect(result.dutyRateApplied, 0.06);
    });

    test('applies 15% duty for gasoline between 1201cc and 1800cc', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1500,
        isElectric: false,
        exchangeRateDzd: 135,
      );
      final result = engine.execute(input);
      expect(result.dutyRateApplied, 0.15);
    });

    test('applies 15% duty exactly at 1800cc boundary', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1800,
        isElectric: false,
        exchangeRateDzd: 135,
      );
      final result = engine.execute(input);
      expect(result.dutyRateApplied, 0.15);
    });

    test('applies 24% duty for gasoline > 1800cc', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1801,
        isElectric: false,
        exchangeRateDzd: 135,
      );
      final result = engine.execute(input);
      expect(result.dutyRateApplied, 0.24);
    });
  });

  group('CIF and tax cascade correctness', () {
    test('computes CIF, CS, VAT, and RPS in correct sequential cascade', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        marineInsuranceRate: 0.015,
        engineCc: 1500,
        isElectric: false,
        exchangeRateDzd: 135,
        useParallelMarket: false,
        portDays: 15,
      );
      final result = engine.execute(input);

      const expectedCifUsd = 10000 + 1000 + (10000 * 0.015);
      expect(result.cifUsd, closeTo(expectedCifUsd, 0.001));

      const expectedCifDzd = expectedCifUsd * 135;
      expect(result.cifDzd, closeTo(expectedCifDzd, 0.01));

      final expectedDuty = expectedCifDzd * 0.15;
      expect(result.customsDutyDzd, closeTo(expectedDuty, 0.01));

      final expectedCs = expectedCifDzd * 0.03;
      expect(result.solidarityTaxDzd, closeTo(expectedCs, 0.01));

      final expectedVat = (expectedCifDzd + expectedDuty + expectedCs) * 0.19;
      expect(result.vatDzd, closeTo(expectedVat, 0.01));

      expect(result.fixedRpsDzd, 2500.0);

      final expectedTotalTaxes =
          expectedDuty + expectedCs + expectedVat + 2500.0;
      expect(result.totalCustomsTaxesDzd, closeTo(expectedTotalTaxes, 0.01));
    });

    test('grand total equals sum of all cost components', () {
      const input = CalculationInput(
        fobPriceUsd: 12000,
        oceanFreightUsd: 1200,
        engineCc: 1500,
        exchangeRateDzd: 135,
        portDays: 20,
      );
      final result = engine.execute(input);

      final expectedGrandTotal = result.cifDzd +
          result.totalCustomsTaxesDzd +
          result.portHandlingStorageDzd +
          result.brokerAndExpertFeesDzd;

      expect(result.grandTotalDzd, closeTo(expectedGrandTotal, 0.01));
      expect(
        result.grandTotalMillionCentimes,
        closeTo(
          result.grandTotalDzd / AppConstants.dzdToMillionCentimes,
          0.0001,
        ),
      );
    });

    test('port handling scales correctly with portDays', () {
      const inputShort = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1500,
        exchangeRateDzd: 135,
        portDays: 5,
      );
      const inputLong = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1500,
        exchangeRateDzd: 135,
        portDays: 30,
      );
      final resultShort = engine.execute(inputShort);
      final resultLong = engine.execute(inputLong);

      expect(resultShort.portHandlingStorageDzd, 45000 + (5 * 1500));
      expect(resultLong.portHandlingStorageDzd, 45000 + (30 * 1500));
      expect(
        resultLong.portHandlingStorageDzd,
        greaterThan(resultShort.portHandlingStorageDzd),
      );
    });
  });

  group('Dual currency engine — official vs parallel market', () {
    test('official rate produces lower CIF_DZD than parallel market rate', () {
      const baseInput = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1500,
        exchangeRateDzd: 135,
        parallelMarketRateDzd: 240,
      );

      final officialResult = engine.execute(
        baseInput.copyWith(useParallelMarket: false),
      );
      final parallelResult = engine.execute(
        baseInput.copyWith(useParallelMarket: true),
      );

      expect(officialResult.cifDzd, lessThan(parallelResult.cifDzd));

      const expectedRatio = 240 / 135;
      final actualRatio = parallelResult.cifDzd / officialResult.cifDzd;
      expect(actualRatio, closeTo(expectedRatio, 0.001));
    });

    test('parallel market mode uses parallelMarketRateDzd exclusively', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 0,
        marineInsuranceRate: 0,
        engineCc: 1500,
        exchangeRateDzd: 135,
        parallelMarketRateDzd: 300,
        useParallelMarket: true,
      );
      final result = engine.execute(input);
      expect(result.cifDzd, closeTo(10000 * 300, 0.01));
    });
  });

  group('Dépannage / tow truck cost exclusion integrity', () {
    test('grand total contains no hidden dépannage/tow cost component', () {
      const input = CalculationInput(
        fobPriceUsd: 10000,
        oceanFreightUsd: 1000,
        engineCc: 1500,
        exchangeRateDzd: 135,
        portDays: 15,
      );
      final result = engine.execute(input);

      final reconstructedTotal = result.cifDzd +
          result.totalCustomsTaxesDzd +
          result.portHandlingStorageDzd +
          result.brokerAndExpertFeesDzd;

      // If any undocumented dépannage cost were silently added, this
      // reconciliation would fail, since it's the exhaustive sum of
      // every documented component.
      expect(result.grandTotalDzd, closeTo(reconstructedTotal, 0.01));
    });

    test('AppConstants explicitly flags dépannage exclusion as true', () {
      expect(AppConstants.excludeDepannageCosts, isTrue);
    });
  });
}
