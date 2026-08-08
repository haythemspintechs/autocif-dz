import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../bloc/calculator_bloc.dart';
import '../widgets/calculator_input_form.dart';
import '../widgets/cost_breakdown_section.dart';
import '../widgets/duty_tier_badge.dart';
import '../widgets/hero_result_card.dart';
import '../widgets/presets_carousel.dart';

/// Main Calculator screen. Provides the CalculatorBloc and composes
/// all sub-widgets in a scrollable, RTL-aware layout.
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorBloc(),
      child: const _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatelessWidget {
  const _CalculatorView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textDirection = Directionality.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Directionality(
        textDirection: textDirection,
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PresetsCarousel(),
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CalculatorInputForm(),
                  ),
                ),
                SizedBox(height: 16),
                DutyTierBadge(),
                SizedBox(height: 20),
                HeroResultCard(),
                SizedBox(height: 20),
                CostBreakdownSection(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
