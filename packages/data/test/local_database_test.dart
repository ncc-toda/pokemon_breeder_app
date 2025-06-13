import 'package:data/src/services/local_storage/database.dart';
import 'package:test/test.dart';

void main() {
  test('LocalDatabase can be instantiated', () async {
    final db = LocalDatabase();
    expect(db, isNotNull);
    await db.close();
  });
}
