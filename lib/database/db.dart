import 'package:inventory/models/medicine.dart';
import 'package:inventory/models/medicine_types.dart' as medicineTypes;
import 'package:sqflite/sqflite.dart';
import 'package:inventory/models/medicine.dart' as medicine;
import '../models/medicine_types.dart';

class MedicineTypeDataBase {
  static final MedicineTypeDataBase instance = MedicineTypeDataBase._init();

  static Database? _database;
  MedicineTypeDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('medicine.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      // onUpgrade: (db, oldVersion, newVersion) {
      //   if (oldVersion == 1) {
      //     db.execute(
      //         '''ALTER TABLE ${medicineTypes.medicineTypesTable} ADD COLUMN ${medicineTypes.MedicineTypesFields.quantity} String DEFAULT "${0}"''');
      //   }
      // },
    );
  }

  Future _createDB(Database db, int version) async {
    db.execute('''
      CREATE TABLE ${medicineTypes.medicineTypesTable}(
        ${medicineTypes.MedicineTypesFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${medicineTypes.MedicineTypesFields.name} TEXT NOT NULL,
        ${medicineTypes.MedicineTypesFields.description} TEXT NOT NULL,
        ${medicineTypes.MedicineTypesFields.quantity} TEXT NOT NULL
      )''');
  }

  // Future<MedicineTypes> create(MedicineTypes medicineType) async {
  //   final db = await instance.database;
  //   final json = medicineType.toJson();
  //   const columns =
  //       '"${medicineTypes.MedicineTypesFields.name}", "${medicineTypes.MedicineTypesFields.description}", "${medicineTypes.MedicineTypesFields.quantity}"';
  //   final values =
  //       ''''"${json[medicineTypes.MedicineTypesFields.name]}", "${json[medicineTypes.MedicineTypesFields.description]}", '${json[medicineTypes.MedicineTypesFields.quantity]}' ''';

  //   final id = await db.rawInsert(
  //       '''INSERT INTO ${medicineTypes.medicineTypesTable} ($columns) VALUES ($values)''');
  //   print(id);
  //   return medicineType.copy(id: id);
  // }
  Future<MedicineTypes> create(MedicineTypes medicineType) async {
  final db = await instance.database;
  final json = medicineType.toJson();
  const columns =
      '"${medicineTypes.MedicineTypesFields.name}", "${medicineTypes.MedicineTypesFields.description}", "${medicineTypes.MedicineTypesFields.quantity}"';
  final quantity = json[medicineTypes.MedicineTypesFields.quantity].toString().replaceAll('"', '\\"');
  final values =
      '''"${json[medicineTypes.MedicineTypesFields.name]}", "${json[medicineTypes.MedicineTypesFields.description]}", '$quantity' ''';

  final id = await db.rawInsert(
      '''INSERT INTO ${medicineTypes.medicineTypesTable} ($columns) VALUES ($values)''');
  print(id);
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

  Future<List<MedicineTypes>> readAllMedicineTypes() async {
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

  Future<int> updateMedicineQuantity(MedicineTypes medicineType) async {
    final db = await instance.database;
    return db.rawUpdate('''
      UPDATE ${medicineTypes.medicineTypesTable}
      SET ${medicineTypes.MedicineTypesFields.quantity} = '${medicineType.quantity}',
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

class MedicineDataBase {
  static final MedicineDataBase instance = MedicineDataBase._init();

  static Database? _database;
  MedicineDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('medicineName.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      // onUpgrade: (db, oldVersion, newVersion) {
      //   if (oldVersion == 1) {
      //     db.execute(
      //         '''ALTER TABLE ${medicineTypes.medicineTypesTable} ADD COLUMN ${medicineTypes.MedicineTypesFields.quantity} INTEGER DEFAULT ${0}''');
      //   }
      // },
    );
  }

  Future _createDB(Database db, int version) async {
    db.execute('''
      CREATE TABLE ${medicine.medicineTable}(
        ${medicine.MedicineFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${medicine.MedicineFields.name} TEXT NOT NULL,
        ${medicine.MedicineFields.description} TEXT NOT NULL,
        ${medicine.MedicineFields.medicineType} TEXT NOT NULL,
        ${medicine.MedicineFields.quantity} String NOT NULL,
      )''');
  }

  Future<Medicine> create(Medicine m) async {
    final db = await instance.database;
    final json = m.toJson();
    const columns =
        '"${medicine.MedicineFields.name}", "${medicine.MedicineFields.description}", "${medicine.MedicineFields.quantity}", "${medicine.MedicineFields.medicineType}"';
    final values =
        '"${json[medicineTypes.MedicineTypesFields.name]}", "${json[medicineTypes.MedicineTypesFields.description]}"';

    final id = await db.rawInsert(
        '''INSERT INTO ${medicineTypes.medicineTypesTable} ($columns) VALUES ($values)''');
    print(id);
    return m.copy(id: id);
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

  Future<List<MedicineTypes>> readAllMedicineTypes() async {
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
