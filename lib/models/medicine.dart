// ignore_for_file: public_member_api_docs, sort_constructors_first

const String medicineTable = 'medicine';

class MedicineFields{
  static const String id = '_id';
  static const String name = 'name';
  static const  String description = 'description';
  static const String quantity = 'quantity';
  static const String medicineType = 'medicine_type';
}
class Medicine {
  late final int? id;
  late final String name;
  late final String description;
  late final String quantity;
  late final String medicineType;
  Medicine({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.medicineType
  });

  Map<String , Object?> toJson() => {
    MedicineFields.id: id,
    MedicineFields.name: name,
    MedicineFields.description: description,
    MedicineFields.quantity: quantity,
    MedicineFields.medicineType: medicineType
  };

  Medicine copy({
    int? id,
    String? name,
    String? description,
    String? quantity,
    String? medicineType
  }) => Medicine(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    medicineType: medicineType ?? this.medicineType

  );
  static Medicine fromJson(Map<String, Object?> json) => Medicine(
    id: json[MedicineFields.id] as int?,
    name: json[MedicineFields.name] as String,
    description: json[MedicineFields.description] as String,
    quantity: json[MedicineFields.quantity] as String,
    medicineType: json[MedicineFields.medicineType] as String
  );
}
