import 'package:inventory/models/medicine_types.dart' as medicineTypes;
import 'package:sqflite/sqflite.dart';

import '../models/medicine_types.dart';

class MedicineDataBase {
  static final MedicineDataBase instance = MedicineDataBase._init();

  static Database? _database;
  MedicineDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('medicine.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    db.execute('''
      CREATE TABLE ${medicineTypes.medicineTypesTable}(
        ${medicineTypes.MedicineTypesFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${medicineTypes.MedicineTypesFields.name} TEXT NOT NULL,
        ${medicineTypes.MedicineTypesFields.description} TEXT NOT NULL
      )''');
  }

  Future<medicineTypes.MedicineTypes> create(
      medicineTypes.MedicineTypes medicineType) async {
    final db = await instance.database;
    final json = medicineType.toJson();
    const columns =
        '${medicineTypes.MedicineTypesFields.name}, ${medicineTypes.MedicineTypesFields.description}';
    final values =
        '${json[medicineTypes.MedicineTypesFields.name]}, ${json[medicineTypes.MedicineTypesFields.description]}';

    final id = await db.rawInsert(
        'INSERT INTO ${medicineTypes.medicineTypesTable} ($columns) VALUES ($values)');
    return medicineType.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<MedicineTypes>> readAllMedicineTypesOfName(
      String queryInfo) async {
    final db = await instance.database;
    final result =
        await db.rawQuery('''SELECT * FROM ${medicineTypes.medicineTypesTable}
        where ${medicineTypes.MedicineTypesFields.name} like '%$queryInfo%'
        ''');

    return result.map((json) => MedicineTypes.fromJson(json)).toList();
  }

  Future<List<MedicineTypes>> readAllMedicineTypes(String queryInfo) async {
    final db = await instance.database;
    final result =
        await db.rawQuery('''SELECT * FROM ${medicineTypes.medicineTypesTable}
      
        ''');

    return result.map((json) => MedicineTypes.fromJson(json)).toList();
  }

  Future<int> updateMedicineType(MedicineTypes medicineType) async {
    final db = await instance.database;
    return db.rawUpdate('''
      UPDATE ${medicineTypes.medicineTypesTable}
      SET ${medicineTypes.MedicineTypesFields.name} = '${medicineType.name}',
      ${medicineTypes.MedicineTypesFields.description} = '${medicineType.description}'
      WHERE ${medicineTypes.MedicineTypesFields.id} = ${medicineType.id}
      ''');
  }

  Future<int> deleteMedicineType(int id) async {
    final db = await instance.database;
    return await db.rawDelete('''
      DELETE FROM ${medicineTypes.medicineTypesTable}
      WHERE ${medicineTypes.MedicineTypesFields.id} = $id
      ''');
  }
}
