import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_state.dart';

/// Visual indicator for the currently applicable Article 110 duty tier.
/// Color and label update reactively as engine type/capacity changes.
class DutyTierBadge extends StatelessWidget {
  const DutyTierBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (prev, curr) =>
          prev.result.dutyRateApplied != curr.result.dutyRateApplied,
      builder: (context, state) {
        final rate = state.result.dutyRateApplied;
        final config = _resolveConfig(rate, l10n);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: config.color.withOpacity(0.14),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: config.color, width: 1.4),
          ),
          child: Row(
            children: [
              Icon(config.icon, color: config.color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.sectionTierTitle,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: config.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      config.label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: config.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: config.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(rate * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _TierConfig _resolveConfig(double rate, AppLocalizations l10n) {
    if (rate <= 0.06) {
      return _TierConfig(
        color: const Color(0xFF43A047), // Light Green
        icon: Icons.eco,
        label: l10n.tierLow,
      );
    } else if (rate <= 0.15) {
      return _TierConfig(
        color: const Color(0xFFF9A825), // Amber
        icon: Icons.warning_amber_rounded,
        label: l10n.tierMid,
      );
    } else {
      return _TierConfig(
        color: const Color(0xFFE64A19), // Orange/Red
        icon: Icons.local_fire_department,
        label: l10n.tierHigh,
      );
    }
  }
}

class _TierConfig {
  final Color color;
  final IconData icon;
  final String label;

  _TierConfig({required this.color, required this.icon, required this.label});
}
