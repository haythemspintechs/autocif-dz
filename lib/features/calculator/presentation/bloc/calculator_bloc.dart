import 'package:bloc/bloc.dart';
import '../../domain/usecases/calculate_customs.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateCustoms _calculateCustoms;

  CalculatorBloc({CalculateCustoms? calculateCustoms})
    : _calculateCustoms = calculateCustoms ?? const CalculateCustoms(),
      super(CalculatorState.initial()) {
    on<FobPriceChanged>(
      (event, emit) =>
          _recalculate(emit, state.input.copyWith(fobPriceUsd: event.value)),
    );

    on<OceanFreightChanged>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(oceanFreightUsd: event.value),
      ),
    );

    on<MarineInsuranceRateChanged>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(marineInsuranceRate: event.value),
      ),
    );

    on<EngineCcChanged>(
      (event, emit) =>
          _recalculate(emit, state.input.copyWith(engineCc: event.value)),
    );

    on<FuelTypeToggled>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(isElectric: event.isElectric),
      ),
    );

    on<ExchangeRateModeToggled>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(useParallelMarket: event.useParallelMarket),
      ),
    );

    on<OfficialRateChanged>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(exchangeRateDzd: event.value),
      ),
    );

    on<ParallelRateChanged>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(parallelMarketRateDzd: event.value),
      ),
    );

    on<PortDaysChanged>(
      (event, emit) =>
          _recalculate(emit, state.input.copyWith(portDays: event.value)),
    );

    on<PresetSelected>(
      (event, emit) => _recalculate(
        emit,
        state.input.copyWith(
          fobPriceUsd: event.preset.defaultPriceUsd,
          engineCc: event.preset.defaultEngineCc,
          isElectric: event.preset.isElectric,
        ),
      ),
    );

    on<CalculatorReset>((event, emit) => emit(CalculatorState.initial()));
  }

  void _recalculate(Emitter<CalculatorState> emit, dynamic updatedInput) {
    final result = _calculateCustoms.execute(updatedInput);
    emit(state.copyWith(input: updatedInput, result: result));
  }
}
