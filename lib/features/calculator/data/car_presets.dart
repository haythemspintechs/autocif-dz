import '../domain/models/car_preset.dart';

/// Initial curated presets for popular Chinese imports currently sold
/// in Algeria. FOB USD values are rough factory-export estimates.
class CarPresets {
  CarPresets._();

  static const List<CarPreset> presets = [
    CarPreset(
      id: 'mg5',
      name: 'MG 5',
      brand: 'MG',
      defaultPriceUsd: 13500,
      defaultEngineCc: 1500,
      isElectric: false,
    ),
    CarPreset(
      id: 'geely_gx3_pro',
      name: 'GX3 Pro',
      brand: 'Geely',
      defaultPriceUsd: 11800,
      defaultEngineCc: 1500,
      isElectric: false,
    ),
    CarPreset(
      id: 'chery_tiggo2_pro',
      name: 'Tiggo 2 Pro',
      brand: 'Chery',
      defaultPriceUsd: 12000,
      defaultEngineCc: 1500,
      isElectric: false,
    ),
    CarPreset(
      id: 'changan_alsvin',
      name: 'Alsvin',
      brand: 'Changan',
      defaultPriceUsd: 10500,
      defaultEngineCc: 1500,
      isElectric: false,
    ),
    CarPreset(
      id: 'byd_dolphin',
      name: 'Dolphin',
      brand: 'BYD',
      defaultPriceUsd: 17500,
      defaultEngineCc: 0,
      isElectric: true,
    ),
    CarPreset(
      id: 'custom',
      name: 'Custom Vehicle',
      brand: 'Other',
      defaultPriceUsd: 10000,
      defaultEngineCc: 1200,
      isElectric: false,
    ),
  ];
}
