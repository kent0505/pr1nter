import 'package:sqflite/sqflite.dart';

import '../models/test.dart';

abstract interface class TestRepository {
  const TestRepository();

  Future<List<Test>> loadTests();
  Future<void> addTest(Test model);
  Future<void> editTest(Test model);
  Future<void> deleteTest(Test model);
}

final class TestRepositoryImpl implements TestRepository {
  TestRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<Test>> loadTests() async {
    final maps = await _db.query(Test.table);
    return maps.map((map) {
      return Test.fromMap(map);
    }).toList();
  }

  @override
  Future<void> addTest(Test model) async {
    await _db.insert(
      Test.table,
      model.toMap(),
    );
  }

  @override
  Future<void> editTest(Test model) async {
    await _db.update(
      Test.table,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> deleteTest(Test model) async {
    await _db.delete(
      Test.table,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
}
