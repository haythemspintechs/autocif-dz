import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autocif_dz/features/checklist/data/checklist_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ChecklistRepository', () {
    test('loadItems returns 10 ordered items unchecked by default', () async {
      final repo = ChecklistRepository();

      final items = await repo.loadItems();

      expect(items.length, 10);
      expect(items.every((item) => item.isDone == false), isTrue);

      for (var i = 0; i < items.length - 1; i++) {
        expect(items[i].order, lessThan(items[i + 1].order));
      }
    });

    test('setItemDone persists state across reloads', () async {
      final repo = ChecklistRepository();

      await repo.setItemDone('gray_card', true);

      final items = await repo.loadItems();
      final grayCard = items.firstWhere((item) => item.id == 'gray_card');

      expect(grayCard.isDone, isTrue);
    });

    test('setItemDone can also persist unchecked state', () async {
      final repo = ChecklistRepository();

      await repo.setItemDone('gray_card', true);
      await repo.setItemDone('gray_card', false);

      final items = await repo.loadItems();
      final grayCard = items.firstWhere((item) => item.id == 'gray_card');

      expect(grayCard.isDone, isFalse);
    });
  });
}
