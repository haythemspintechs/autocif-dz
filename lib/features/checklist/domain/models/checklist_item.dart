import 'package:equatable/equatable.dart';

class ChecklistItem extends Equatable {
  final String id;
  final String titleKey; // resolved via ARB lookup at UI layer
  final String descriptionKey;
  final int order;
  final bool isDone;

  const ChecklistItem({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.order,
    this.isDone = false,
  });

  ChecklistItem copyWith({bool? isDone}) => ChecklistItem(
    id: id,
    titleKey: titleKey,
    descriptionKey: descriptionKey,
    order: order,
    isDone: isDone ?? this.isDone,
  );

  @override
  List<Object?> get props => [id, titleKey, descriptionKey, order, isDone];
}
