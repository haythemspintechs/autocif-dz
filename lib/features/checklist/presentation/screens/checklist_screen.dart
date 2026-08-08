import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/models/checklist_item.dart';
import '../bloc/checklist_cubit.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChecklistCubit(),
      child: const _ChecklistView(),
    );
  }
}

class _ChecklistView extends StatelessWidget {
  const _ChecklistView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.checklistTitle)),
      body: BlocBuilder<ChecklistCubit, List<ChecklistItem>>(
        builder: (context, items) {
          if (items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final doneCount = items.where((i) => i.isDone).length;
          final progress = items.isEmpty ? 0.0 : doneCount / items.length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: Colors.grey.shade200,
                      color: AppColors.primaryEmerald,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$doneCount / ${items.length} completed',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: CheckboxListTile(
                        value: item.isDone,
                        activeColor: AppColors.primaryEmerald,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          '${item.order}. ${_resolveTitle(l10n, item.titleKey)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: item.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: item.isDone ? Colors.grey : null,
                          ),
                        ),
                        subtitle: Text(_resolveDesc(l10n, item.descriptionKey)),
                        onChanged: (_) =>
                            context.read<ChecklistCubit>().toggleItem(item.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Maps ARB keys to localized strings. Extend ARB files with these
  // keys (checklistExportInvoice, checklistExportInvoiceDesc, etc.)
  String _resolveTitle(AppLocalizations l10n, String key) {
    const fallback = {
      'checklistExportInvoice': 'Export Invoice',
      'checklistCertOrigin': 'Certificate of Origin (EUR.1)',
      'checklistBillOfLading': 'Bill of Lading',
      'checklistInsuranceCert': 'Marine Insurance Certificate',
      'checklistCustomsDeclaration': 'Customs Declaration (D10)',
      'checklistCustomsInspection': 'Customs Inspection',
      'checklistDutyTaxPayment': 'Duty & Tax Payment',
      'checklistTechnicalInspection': 'Technical Inspection',
      'checklistGrayCard': 'Gray Card Processing',
      'checklistPlateRegistration': 'License Plate Registration',
    };
    return fallback[key] ?? key;
  }

  String _resolveDesc(AppLocalizations l10n, String key) {
    const fallback = {
      'checklistExportInvoiceDesc':
          'Commercial invoice from the seller/exporter showing FOB value.',
      'checklistCertOriginDesc':
          'Proof of manufacturing origin, may affect duty preferences.',
      'checklistBillOfLadingDesc':
          'Shipping document issued by the carrier upon loading.',
      'checklistInsuranceCertDesc': 'Proof of marine cargo insurance coverage.',
      'checklistCustomsDeclarationDesc':
          'Filed with Algerian customs upon arrival at port.',
      'checklistCustomsInspectionDesc':
          'Physical inspection by customs officials.',
      'checklistDutyTaxPaymentDesc':
          'Payment of DD, CS, TVA, and RPS at customs office.',
      'checklistTechnicalInspectionDesc':
          'Roadworthiness and compliance inspection.',
      'checklistGrayCardDesc':
          'Official vehicle registration document (Carte Grise).',
      'checklistPlateRegistrationDesc':
          'Final step: obtaining local license plates.',
    };
    return fallback[key] ?? key;
  }
}
