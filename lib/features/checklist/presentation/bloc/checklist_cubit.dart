import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/checklist_repository.dart';
import '../../domain/models/checklist_item.dart';

class ChecklistCubit extends Cubit<List<ChecklistItem>> {
  final ChecklistRepository _repository;

  ChecklistCubit({ChecklistRepository? repository})
    : _repository = repository ?? ChecklistRepository(),
      super(const []) {
    _load();
  }

  Future<void> _load() async {
    final items = await _repository.loadItems();
    emit(items);
  }

  Future<void> toggleItem(String id) async {
    final updated = state
        .map(
          (item) => item.id == id ? item.copyWith(isDone: !item.isDone) : item,
        )
        .toList();
    emit(updated);
    final toggled = updated.firstWhere((i) => i.id == id);
    await _repository.setItemDone(id, toggled.isDone);
  }
}
