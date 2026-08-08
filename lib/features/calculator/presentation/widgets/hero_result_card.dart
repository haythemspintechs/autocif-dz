import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_state.dart';

/// Prominent emerald hero card showing the grand total in both
/// Million Centimes and DZD, plus a mini summary grid and the
/// mandatory dépannage exclusion disclaimer.
class HeroResultCard extends StatelessWidget {
  const HeroResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).languageCode;

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (prev, curr) => prev.result != curr.result,
      builder: (context, state) {
        final result = state.result;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryEmerald, AppColors.primaryEmeraldDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryEmerald.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.breakdownTotal,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                    '${result.grandTotalMillionCentimes.toStringAsFixed(2)} ${l10n.currencyMillionCentimes}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                  .animate(key: ValueKey(result.grandTotalDzd))
                  .fadeIn(duration: 250.ms)
                  .scale(begin: const Offset(0.96, 0.96)),
              Text(
                '(${CurrencyFormatter.formatDzd(result.grandTotalDzd, localeCode: localeCode)})',
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  _MiniStat(
                    label: l10n.breakdownCif,
                    value: CurrencyFormatter.formatDzd(
                      result.cifDzd,
                      localeCode: localeCode,
                    ),
                  ),
                  _MiniStat(
                    label: 'Customs & Taxes',
                    value: CurrencyFormatter.formatDzd(
                      result.totalCustomsTaxesDzd,
                      localeCode: localeCode,
                    ),
                  ),
                  _MiniStat(
                    label: 'Port & Admin',
                    value: CurrencyFormatter.formatDzd(
                      result.portHandlingStorageDzd +
                          result.brokerAndExpertFeesDzd,
                      localeCode: localeCode,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.amberAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.depannageDisclaimer,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
