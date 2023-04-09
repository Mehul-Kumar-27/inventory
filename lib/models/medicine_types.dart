// ignore_for_file: public_member_api_docs, sort_constructors_first

const String medicineTypesTable = 'medicine_types';

class MedicineTypesFields {
  static const String id = 'id';
  static const String medicineTypeName = 'medicineTypeName';
  static const String medicineTypeDescription = 'medicineTypeDescription';
  static const String medicineTypeQuantity = 'medicineTypeQuantity';
}

class MedicineTypes {
  late final int? id;
  late final String medicineTypeName;
  late final String medicineTypeDescription;
  late final String medicineTypeQuantity;
  MedicineTypes(
      {this.id,
      required this.medicineTypeName,
      required this.medicineTypeDescription,
      required this.medicineTypeQuantity});

  Map<String, Object?> toJson() => {
        MedicineTypesFields.id: id,
        MedicineTypesFields.medicineTypeName: medicineTypeName,
        MedicineTypesFields.medicineTypeDescription: medicineTypeDescription,
        MedicineTypesFields.medicineTypeQuantity: medicineTypeQuantity
      };

  MedicineTypes copy(
          {int? id, String? medicineTypeName, String? medicineTypeDescription, String? medicineTypeQuantity}) =>
      MedicineTypes(
          id: id ?? this.id,
          medicineTypeName: medicineTypeName ?? this.medicineTypeName,
          medicineTypeDescription: medicineTypeDescription ?? this.medicineTypeDescription,
          medicineTypeQuantity: medicineTypeQuantity ?? this.medicineTypeQuantity);
  static MedicineTypes fromJson(Map<String, Object?> json) => MedicineTypes(
      id: json[MedicineTypesFields.id] as int?,
      medicineTypeName: json[MedicineTypesFields.medicineTypeName] as String,
      medicineTypeDescription: json[MedicineTypesFields.medicineTypeDescription] as String,
      medicineTypeQuantity: json[MedicineTypesFields.medicineTypeQuantity] as String);
}
