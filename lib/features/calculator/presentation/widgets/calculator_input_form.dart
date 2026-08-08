import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

/// Full dynamic input form: FOB/freight fields, engine type toggle,
/// engine capacity control, exchange rate mode switcher, and port days.
class CalculatorInputForm extends StatefulWidget {
  const CalculatorInputForm({super.key});

  @override
  State<CalculatorInputForm> createState() => _CalculatorInputFormState();
}

class _CalculatorInputFormState extends State<CalculatorInputForm> {
  late TextEditingController _fobController;
  late TextEditingController _freightController;
  late TextEditingController _officialRateController;
  late TextEditingController _parallelRateController;

  @override
  void initState() {
    super.initState();
    final input = context.read<CalculatorBloc>().state.input;
    _fobController = TextEditingController(
      text: input.fobPriceUsd == 0 ? '' : input.fobPriceUsd.toStringAsFixed(0),
    );
    _freightController = TextEditingController(
      text: input.oceanFreightUsd == 0
          ? ''
          : input.oceanFreightUsd.toStringAsFixed(0),
    );
    _officialRateController = TextEditingController(
      text: input.exchangeRateDzd.toStringAsFixed(1),
    );
    _parallelRateController = TextEditingController(
      text: input.parallelMarketRateDzd.toStringAsFixed(1),
    );
  }

  @override
  void dispose() {
    _fobController.dispose();
    _freightController.dispose();
    _officialRateController.dispose();
    _parallelRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        final input = state.input;

        // Keep controllers in sync when a preset overwrites values.
        _syncControllerIfNeeded(_fobController, input.fobPriceUsd);
        _syncControllerIfNeeded(_freightController, input.oceanFreightUsd);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.inputSectionTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    controller: _fobController,
                    label: l10n.labelFobPrice,
                    prefixText: '\$ ',
                    onChanged: (v) => context.read<CalculatorBloc>().add(
                      FobPriceChanged(double.tryParse(v) ?? 0),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    controller: _freightController,
                    label: l10n.labelOceanFreight,
                    prefixText: '\$ ',
                    onChanged: (v) => context.read<CalculatorBloc>().add(
                      OceanFreightChanged(double.tryParse(v) ?? 0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              l10n.labelEngineType,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(l10n.engineTypeGasoline),
                  icon: const Icon(Icons.local_gas_station),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(l10n.engineTypeElectric),
                  icon: const Icon(Icons.electric_bolt),
                ),
              ],
              selected: {input.isElectric},
              onSelectionChanged: (selection) => context
                  .read<CalculatorBloc>()
                  .add(FuelTypeToggled(selection.first)),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppColors.primaryEmerald,
                selectedForegroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            AnimatedOpacity(
              opacity: input.isElectric ? 0.4 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: input.isElectric,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.labelEngineCapacity,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '${input.engineCc} cc',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryEmerald,
                              ),
                        ),
                      ],
                    ),
                    Slider(
                      value: input.engineCc.clamp(600, 3500).toDouble(),
                      min: 600,
                      max: 3500,
                      divisions: 58,
                      activeColor: AppColors.primaryEmerald,
                      label: '${input.engineCc} cc',
                      onChanged: (v) => context.read<CalculatorBloc>().add(
                        EngineCcChanged(v.round()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              l10n.labelExchangeRateMode,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(l10n.exchangeRateOfficial),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(l10n.exchangeRateSquare),
                ),
              ],
              selected: {input.useParallelMarket},
              onSelectionChanged: (selection) => context
                  .read<CalculatorBloc>()
                  .add(ExchangeRateModeToggled(selection.first)),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppColors.accentGold,
                selectedForegroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    controller: _officialRateController,
                    label: l10n.exchangeRateOfficial,
                    suffixText: 'DZD',
                    enabled: !input.useParallelMarket,
                    onChanged: (v) => context.read<CalculatorBloc>().add(
                      OfficialRateChanged(
                        double.tryParse(v) ??
                            AppConstants.defaultBankExchangeRate,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    controller: _parallelRateController,
                    label: l10n.exchangeRateSquare,
                    suffixText: 'DZD',
                    enabled: input.useParallelMarket,
                    onChanged: (v) => context.read<CalculatorBloc>().add(
                      ParallelRateChanged(
                        double.tryParse(v) ??
                            AppConstants.defaultSquareExchangeRate,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Port Days',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      color: AppColors.primaryEmerald,
                      onPressed: input.portDays > 0
                          ? () => context.read<CalculatorBloc>().add(
                              PortDaysChanged(input.portDays - 1),
                            )
                          : null,
                    ),
                    Text(
                      '${input.portDays}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      color: AppColors.primaryEmerald,
                      onPressed: () => context.read<CalculatorBloc>().add(
                        PortDaysChanged(input.portDays + 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _syncControllerIfNeeded(TextEditingController controller, double value) {
    final formatted = value == 0 ? '' : value.toStringAsFixed(0);
    if (controller.text != formatted && !controller.selection.isValid) {
      controller.text = formatted;
    }
  }
}

class _NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? prefixText;
  final String? suffixText;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const _NumberField({
    required this.controller,
    required this.label,
    required this.onChanged,
    this.prefixText,
    this.suffixText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        suffixText: suffixText,
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
