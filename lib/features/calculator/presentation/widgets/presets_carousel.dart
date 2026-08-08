import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../data/car_presets.dart';
import '../../domain/models/car_preset.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

/// Horizontal scrollable carousel of popular car presets.
/// Selecting a card dispatches [PresetSelected] to the [CalculatorBloc].
class PresetsCarousel extends StatelessWidget {
  const PresetsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (prev, curr) =>
          prev.input.fobPriceUsd != curr.input.fobPriceUsd ||
          prev.input.engineCc != curr.input.engineCc ||
          prev.input.isElectric != curr.input.isElectric,
      builder: (context, state) {
        return SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: CarPresets.presets.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final preset = CarPresets.presets[index];
              final isSelected =
                  state.input.fobPriceUsd == preset.defaultPriceUsd &&
                  state.input.engineCc == preset.defaultEngineCc &&
                  state.input.isElectric == preset.isElectric;

              return _PresetCard(
                preset: preset,
                isSelected: isSelected,
                fuelLabel: preset.isElectric
                    ? l10n.engineTypeElectric
                    : '${preset.defaultEngineCc} cc',
                onTap: () =>
                    context.read<CalculatorBloc>().add(PresetSelected(preset)),
              );
            },
          ),
        );
      },
    );
  }
}

class _PresetCard extends StatelessWidget {
  final CarPreset preset;
  final bool isSelected;
  final String fuelLabel;
  final VoidCallback onTap;

  const _PresetCard({
    required this.preset,
    required this.isSelected,
    required this.fuelLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryEmerald.withOpacity(0.10)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryEmerald : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  preset.isElectric ? Icons.electric_car : Icons.directions_car,
                  size: 18,
                  color: AppColors.primaryEmerald,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    preset.brand,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              preset.name,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(fuelLabel, style: Theme.of(context).textTheme.bodySmall),
            Text(
              '\$${preset.defaultPriceUsd.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryEmerald,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
