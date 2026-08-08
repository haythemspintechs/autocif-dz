import 'package:equatable/equatable.dart';

/// Represents a popular car model importable to Algeria, used to
/// pre-fill the calculator with realistic default values.
class CarPreset extends Equatable {
  final String id;
  final String name;
  final String brand;
  final double defaultPriceUsd;
  final int defaultEngineCc;
  final bool isElectric;

  const CarPreset({
    required this.id,
    required this.name,
    required this.brand,
    required this.defaultPriceUsd,
    required this.defaultEngineCc,
    required this.isElectric,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    defaultPriceUsd,
    defaultEngineCc,
    isElectric,
  ];
}
