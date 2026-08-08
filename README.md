# AutoCif DZ

**AutoCif DZ** is a Flutter mobile app that helps users in Algeria estimate the total customs cost (CIF + duties + taxes + port/broker fees) of importing a car, based on Algerian Customs Code Article 110 and the current Finance Law tax schedule.

## Features

- **CIF & customs tax calculator** — computes CIF value, customs duty (DD), solidarity tax (CS), VAT (TVA), and fixed RPS fee in a sequential cascade.
- **Article 110 duty tiers** — automatically applies the correct duty rate based on engine size and electric/gasoline status:
  - 6% — Electric vehicles, or gasoline/hybrid ≤ 1200cc
  - 15% — Gasoline/hybrid 1201cc–1800cc
  - 24% — Gasoline/hybrid > 1800cc
- **Dual currency engine** — toggle between the official Banque d'Algérie exchange rate and the parallel market ("Square") rate, both user-editable.
- **Port handling & broker fees** — scales port storage cost with number of port days.
- **Import checklist** — step-by-step document/process checklist (export invoice, certificate of origin, bill of lading, customs declaration, technical inspection, gray card, plate registration, etc.) with persisted completion state.
- **Multi-language support** — Arabic (default), French, and English, with correct RTL handling and forced LTR rendering for numeric/currency values.
- **Light & dark theme**, switchable in Settings, with system-preference default.
- **Export & share** — renders a summary card off-screen and shares it as a high-resolution PNG via the native share sheet.
- **Dépannage (tow truck) cost exclusion** — the app explicitly excludes tow/breakdown transport costs from all totals, since this varies heavily by wilaya, and surfaces a disclaimer wherever a grand total is shown.
- **AdMob integration** — banner and interstitial ads, shown only after a completed calculation flow (never on app launch).

## Tech Stack

- **Flutter** / Dart
- **flutter_bloc** for state management (Cubit/Bloc)
- **shared_preferences** for persisted settings (locale, theme, exchange rates)
- **google_mobile_ads** for monetization
- **screenshot** + **share_plus** + **path_provider** for export/share
- **flutter_animate** for micro-interactions
- Generated localization via `flutter gen-l10n` (`AppLocalizations`)

## Project Structure

```
lib/
├── core/
│   ├── ads/                     # AdHelper, InterstitialAdManager
│   ├── constants/                # AppConstants, AppColors
│   ├── l10n/generated/           # Generated AppLocalizations
│   ├── services/                 # PreferencesService
│   ├── theme/                    # AppTheme (light/dark)
│   └── utils/                    # CurrencyFormatter
├── features/
│   ├── calculator/
│   │   ├── domain/
│   │   │   ├── models/           # CalculationInput, CalculationResult
│   │   │   └── usecases/         # CalculateCustoms engine
│   │   └── presentation/
│   │       ├── bloc/              # CalculatorBloc/State/Event
│   │       ├── screens/           # CalculatorScreen, SettingsScreen, MainNavigationScreen
│   │       └── widgets/           # HeroResultCard, CostBreakdownSection, DutyTierBadge,
│   │                               PresetsCarousel, CalculatorInputForm, ExportSummaryCard
│   └── checklist/
│       ├── domain/models/         # ChecklistItem
│       └── presentation/
│           ├── bloc/               # ChecklistCubit
│           └── screens/            # ChecklistScreen
└── main.dart
```

## Domain Rules (Reference)

| Component | Formula |
|---|---|
| CIF (USD) | `FOB + Ocean Freight + (FOB × Marine Insurance Rate)` |
| CIF (DZD) | `CIF (USD) × Exchange Rate` (official or parallel) |
| Customs Duty (DD) | `CIF (DZD) × Duty Rate Tier` |
| Solidarity Tax (CS) | `CIF (DZD) × 3%` |
| VAT (TVA) | `(CIF + DD + CS) × 19%` |
| Fixed RPS | `2,500 DZD` (flat) |
| Grand Total | `CIF (DZD) + Total Taxes + Port Handling/Storage + Broker & Expert Fees` |
| Million Centimes | `Grand Total (DZD) ÷ 10,000` — since 1 DZD = 100 centimes, 1,000,000 centimes = 10,000 DZD |

> ⚠️ **Dépannage / tow truck costs are never included** in any calculation. This is enforced via `AppConstants.excludeDepannageCosts` and verified by a dedicated reconciliation test.

## Getting Started

### Prerequisites
- Flutter SDK (stable channel)
- Android Studio / a configured Android SDK
- A physical device or emulator (wireless ADB debugging supported)

### Setup

```bash
flutter pub get
flutter gen-l10n
```

### Run

```bash
flutter devices
flutter run -d <device-id>
```

### Test

```bash
flutter test
```

### Analyze

```bash
flutter analyze
```

## AdMob Configuration

The Android manifest requires an AdMob App ID meta-data entry:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713" />
```

The value above is Google's **public test ID** — replace it with your production AdMob App ID (and swap all test ad unit IDs in `AdHelper`) before releasing to the Play Store. Ad SDK initialization is deferred until after the first frame renders, to avoid delaying app startup.

## Release Checklist

- [ ] Replace test AdMob App ID and ad unit IDs with production values (gated by `kReleaseMode`)
- [ ] Configure release signing in `android/app/build.gradle.kts` via `key.properties`
- [ ] Align `namespace`, `applicationId`, and the Kotlin package path (`MainActivity.kt`)
- [ ] Run `flutter analyze` and `flutter test` — both must pass clean
- [ ] Verify Arabic/French/English UI, dark mode, and dual-currency toggle on a real device
- [ ] Verify export/share PNG generation and native share sheet

## License

Internal/proprietary project — not currently open-sourced.