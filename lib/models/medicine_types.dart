// ignore_for_file: public_member_api_docs, sort_constructors_first

const String medicineTypesTable = 'medicine_types';

class MedicineTypesFields{
  static const String id = '_id';
  static const String name = 'name';
  static const  String description = 'description';
}
class MedicineTypes {
  late final int? id;
  late final String name;
  late final String description;
  MedicineTypes({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String , Object?> toJson() => {
    MedicineTypesFields.id: id,
    MedicineTypesFields.name: name,
    MedicineTypesFields.description: description,
  };

  MedicineTypes copy({
    int? id,
    String? name,
    String? description,
  }) => MedicineTypes(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
  );
  static MedicineTypes fromJson(Map<String, Object?> json) => MedicineTypes(
    id: json[MedicineTypesFields.id] as int?,
    name: json[MedicineTypesFields.name] as String,
    description: json[MedicineTypesFields.description] as String,
  );
}
