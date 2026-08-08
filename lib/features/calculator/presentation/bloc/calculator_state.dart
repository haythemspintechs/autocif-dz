import 'package:equatable/equatable.dart';
import '../../domain/models/calculation_input.dart';
import '../../domain/models/calculation_result.dart';

class CalculatorState extends Equatable {
  final CalculationInput input;
  final CalculationResult result;

  const CalculatorState({required this.input, required this.result});

  factory CalculatorState.initial() => const CalculatorState(
    input: CalculationInput(),
    result: CalculationResult.empty,
  );

  CalculatorState copyWith({
    CalculationInput? input,
    CalculationResult? result,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [input, result];
}
