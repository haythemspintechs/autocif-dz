import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/models/calculation_input.dart';
import '../../domain/models/calculation_result.dart';

/// Wraps any numeric/currency text in an explicit LTR bidi boundary.
/// Prevents Arabic RTL context from reordering digits, decimal points,
/// or currency symbols in exported/shared content.
class LtrNumericText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const LtrNumericText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}

/// Off-screen capturable summary card for high-resolution PNG export.
/// Rendered via [ScreenshotController.captureFromWidget] so it never
/// needs to be mounted in the visible widget tree.
class ExportSummaryCard extends StatelessWidget {
  final CalculationInput input;
  final CalculationResult result;
  final AppLocalizations l10n;
  final String localeCode;

  const ExportSummaryCard({
    super.key,
    required this.input,
    required this.result,
    required this.l10n,
    required this.localeCode,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 720,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.primaryEmerald,
                  radius: 22,
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.appTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryEmerald,
                        ),
                      ),
                      Text(
                        l10n.appSubtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryEmerald,
                    AppColors.primaryEmeraldDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.breakdownTotal,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  LtrNumericText(
                    '${result.grandTotalMillionCentimes.toStringAsFixed(2)} ${l10n.currencyMillionCentimes}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  LtrNumericText(
                    '(${CurrencyFormatter.formatDzd(result.grandTotalDzd, localeCode: localeCode)})',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildRow(l10n.breakdownFob, input.fobPriceUsd, isUsd: true),
            _buildRow(
              l10n.breakdownFreight,
              input.oceanFreightUsd,
              isUsd: true,
            ),
            _buildRow(l10n.breakdownCif, result.cifDzd),
            const Divider(height: 24),
            _buildRow(l10n.breakdownCustomsDuty, result.customsDutyDzd),
            _buildRow(l10n.breakdownSolidarityTax, result.solidarityTaxDzd),
            _buildRow(l10n.breakdownVat, result.vatDzd),
            _buildRow(l10n.breakdownRps, result.fixedRpsDzd),
            const Divider(height: 24),
            _buildRow('Port Handling & Storage', result.portHandlingStorageDzd),
            _buildRow('Broker & Expert Fees', result.brokerAndExpertFeesDzd),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber.shade800,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.depannageDisclaimer,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.amber.shade900,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'AutoCif DZ — حاسبة استيراد السيارات',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, double value, {bool isUsd = false}) {
    final formatted = isUsd
        ? '\$${value.toStringAsFixed(0)}'
        : CurrencyFormatter.formatDzd(value, localeCode: localeCode);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          LtrNumericText(
            formatted,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Handles capture-to-PNG and native share sheet invocation.
class ExportShareService {
  static final ScreenshotController controller = ScreenshotController();

  static Future<void> captureAndShare({
    required BuildContext context,
    required CalculationInput input,
    required CalculationResult result,
    required AppLocalizations l10n,
    required String localeCode,
  }) async {
    final Uint8List imageBytes = await controller.captureFromWidget(
      MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: ExportSummaryCard(
          input: input,
          result: result,
          l10n: l10n,
          localeCode: localeCode,
        ),
      ),
      pixelRatio: 3.0,
      delay: const Duration(milliseconds: 80),
    );

    final directory = await getTemporaryDirectory();
    final file = await File(
      '${directory.path}/autocif_dz_summary_${DateTime.now().millisecondsSinceEpoch}.png',
    ).create();

    await file.writeAsBytes(imageBytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'AutoCif DZ — ${l10n.breakdownTotal}: '
          '${result.grandTotalMillionCentimes.toStringAsFixed(2)} ${l10n.currencyMillionCentimes}',
    );
  }
}
