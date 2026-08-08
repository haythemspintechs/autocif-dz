import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_state.dart';

/// Expandable, color-coded itemized cost breakdown grouped into
/// logical sections: CIF Purchase, Customs Duties & Taxes,
/// Port Handling & Storage, and Broker & Expert Fees.
class CostBreakdownSection extends StatelessWidget {
  const CostBreakdownSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).languageCode;

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (prev, curr) => prev.result != curr.result,
      builder: (context, state) {
        final r = state.result;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.breakdownTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            _ExpandableGroup(
              title: l10n.breakdownCif,
              icon: Icons.local_shipping_outlined,
              color: AppColors.fobColor,
              totalLabel: CurrencyFormatter.formatDzd(
                r.cifDzd,
                localeCode: localeCode,
              ),
              children: [
                _LineItem(label: l10n.breakdownFob, color: AppColors.fobColor),
                _LineItem(
                  label: l10n.breakdownFreight,
                  color: AppColors.freightColor,
                ),
                _LineItem(
                  label: l10n.breakdownInsurance,
                  color: AppColors.insuranceColor,
                ),
              ],
            ),
            _ExpandableGroup(
              title: 'Customs Duties & Taxes',
              icon: Icons.receipt_long_outlined,
              color: AppColors.dutyColor,
              totalLabel: CurrencyFormatter.formatDzd(
                r.totalCustomsTaxesDzd,
                localeCode: localeCode,
              ),
              children: [
                _LineItem(
                  label: l10n.breakdownCustomsDuty,
                  value: r.customsDutyDzd,
                  color: AppColors.dutyColor,
                  localeCode: localeCode,
                ),
                _LineItem(
                  label: l10n.breakdownSolidarityTax,
                  value: r.solidarityTaxDzd,
                  color: AppColors.taxColor,
                  localeCode: localeCode,
                ),
                _LineItem(
                  label: l10n.breakdownVat,
                  value: r.vatDzd,
                  color: AppColors.taxColor,
                  localeCode: localeCode,
                ),
                _LineItem(
                  label: l10n.breakdownRps,
                  value: r.fixedRpsDzd,
                  color: AppColors.feesColor,
                  localeCode: localeCode,
                ),
              ],
            ),
            _ExpandableGroup(
              title: 'Port Handling & Storage',
              icon: Icons.warehouse_outlined,
              color: AppColors.feesColor,
              totalLabel: CurrencyFormatter.formatDzd(
                r.portHandlingStorageDzd,
                localeCode: localeCode,
              ),
              children: [
                _LineItem(
                  label: 'Base + Storage Days',
                  value: r.portHandlingStorageDzd,
                  color: AppColors.feesColor,
                  localeCode: localeCode,
                ),
              ],
            ),
            _ExpandableGroup(
              title: 'Customs Broker & Expert Fees',
              icon: Icons.badge_outlined,
              color: AppColors.insuranceColor,
              totalLabel: CurrencyFormatter.formatDzd(
                r.brokerAndExpertFeesDzd,
                localeCode: localeCode,
              ),
              children: [
                _LineItem(
                  label: l10n.breakdownBrokerFee,
                  color: AppColors.insuranceColor,
                ),
                _LineItem(
                  label:
                      '${l10n.breakdownExpertInspection} / ${l10n.breakdownGrayCard}',
                  color: AppColors.insuranceColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ExpandableGroup extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String totalLabel;
  final List<Widget> children;

  const _ExpandableGroup({
    required this.title,
    required this.icon,
    required this.color,
    required this.totalLabel,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            totalLabel,
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8,
          ),
          children: children,
        ),
      ),
    );
  }
}

class _LineItem extends StatelessWidget {
  final String label;
  final double? value;
  final Color color;
  final String? localeCode;

  const _LineItem({
    required this.label,
    required this.color,
    this.value,
    this.localeCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          if (value != null && localeCode != null)
            Text(
              CurrencyFormatter.formatDzd(value!, localeCode: localeCode!),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
        ],
      ),
    );
  }
}
