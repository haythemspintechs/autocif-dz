import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/checklist_item.dart';

/// Static ordered list of standard Algerian car import documentation steps.
/// isDone state is persisted per-id via SharedPreferences.
class ChecklistRepository {
  static const _prefsPrefix = 'checklist_item_';

  static const List<ChecklistItem> _baseItems = [
    ChecklistItem(
      id: 'export_invoice',
      titleKey: 'checklistExportInvoice',
      descriptionKey: 'checklistExportInvoiceDesc',
      order: 1,
    ),
    ChecklistItem(
      id: 'certificate_origin',
      titleKey: 'checklistCertOrigin',
      descriptionKey: 'checklistCertOriginDesc',
      order: 2,
    ),
    ChecklistItem(
      id: 'bill_of_lading',
      titleKey: 'checklistBillOfLading',
      descriptionKey: 'checklistBillOfLadingDesc',
      order: 3,
    ),
    ChecklistItem(
      id: 'marine_insurance_cert',
      titleKey: 'checklistInsuranceCert',
      descriptionKey: 'checklistInsuranceCertDesc',
      order: 4,
    ),
    ChecklistItem(
      id: 'customs_declaration',
      titleKey: 'checklistCustomsDeclaration',
      descriptionKey: 'checklistCustomsDeclarationDesc',
      order: 5,
    ),
    ChecklistItem(
      id: 'customs_inspection',
      titleKey: 'checklistCustomsInspection',
      descriptionKey: 'checklistCustomsInspectionDesc',
      order: 6,
    ),
    ChecklistItem(
      id: 'duty_tax_payment',
      titleKey: 'checklistDutyTaxPayment',
      descriptionKey: 'checklistDutyTaxPaymentDesc',
      order: 7,
    ),
    ChecklistItem(
      id: 'technical_inspection',
      titleKey: 'checklistTechnicalInspection',
      descriptionKey: 'checklistTechnicalInspectionDesc',
      order: 8,
    ),
    ChecklistItem(
      id: 'gray_card',
      titleKey: 'checklistGrayCard',
      descriptionKey: 'checklistGrayCardDesc',
      order: 9,
    ),
    ChecklistItem(
      id: 'plate_registration',
      titleKey: 'checklistPlateRegistration',
      descriptionKey: 'checklistPlateRegistrationDesc',
      order: 10,
    ),
  ];

  Future<List<ChecklistItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    return _baseItems
        .map(
          (item) => item.copyWith(
            isDone: prefs.getBool('$_prefsPrefix${item.id}') ?? false,
          ),
        )
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> setItemDone(String id, bool isDone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefsPrefix$id', isDone);
  }
}
