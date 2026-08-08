import 'package:equatable/equatable.dart';
import '../../domain/models/car_preset.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();
  @override
  List<Object?> get props => [];
}

class FobPriceChanged extends CalculatorEvent {
  final double value;
  const FobPriceChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class OceanFreightChanged extends CalculatorEvent {
  final double value;
  const OceanFreightChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class MarineInsuranceRateChanged extends CalculatorEvent {
  final double value;
  const MarineInsuranceRateChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class EngineCcChanged extends CalculatorEvent {
  final int value;
  const EngineCcChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class FuelTypeToggled extends CalculatorEvent {
  final bool isElectric;
  const FuelTypeToggled(this.isElectric);
  @override
  List<Object?> get props => [isElectric];
}

class ExchangeRateModeToggled extends CalculatorEvent {
  final bool useParallelMarket;
  const ExchangeRateModeToggled(this.useParallelMarket);
  @override
  List<Object?> get props => [useParallelMarket];
}

class OfficialRateChanged extends CalculatorEvent {
  final double value;
  const OfficialRateChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class ParallelRateChanged extends CalculatorEvent {
  final double value;
  const ParallelRateChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class PortDaysChanged extends CalculatorEvent {
  final int value;
  const PortDaysChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class PresetSelected extends CalculatorEvent {
  final CarPreset preset;
  const PresetSelected(this.preset);
  @override
  List<Object?> get props => [preset];
}

class CalculatorReset extends CalculatorEvent {
  const CalculatorReset();
}
