// ignore_for_file: public_member_api_docs, sort_constructors_first

const String medicineTypesTable = 'medicine_types';

class MedicineTypesFields{
  static const String id = '_id';
  static const String name = 'name';
  static const  String description = 'description';
  static const String quantity = 'quantity';
}
class MedicineTypes {
  late final int? id;
  late final String name;
  late final String description;
  late final int quantity;
  MedicineTypes({
    this.id,
    required this.name,
    required this.description,
    required this.quantity
  });

  Map<String , Object?> toJson() => {
    MedicineTypesFields.id: id,
    MedicineTypesFields.name: name,
    MedicineTypesFields.description: description,
    MedicineTypesFields.quantity: quantity
  };

  MedicineTypes copy({
    int? id,
    String? name,
    String? description,
    int? quantity
  }) => MedicineTypes(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity
  );
  static MedicineTypes fromJson(Map<String, Object?> json) => MedicineTypes(
    id: json[MedicineTypesFields.id] as int?,
    name: json[MedicineTypesFields.name] as String,
    description: json[MedicineTypesFields.description] as String,
    quantity: json[MedicineTypesFields.quantity] as int
  );
}
