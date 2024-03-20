import 'package:kairasahrl/models/depense_model.dart';

class Conteneure {
  int id;
  String name;
  String plaque;
  String slug;
  String customer;
  String? customerPhone;
  String? broker;
  String? brokerPhone;
  double containerPrice;
  String? containerCityID; // Modifier le type en String
  int? containerType;
  int? status;
  String? containerInformationC;
  String? containerOtherDetails;
  String createdBy;
  String createdAt;
  String? updatedBy;
  String? updatedAt;
  List<Expense>? containerRelatedExpenses;

  Conteneure({
    required this.id,
    required this.name,
    required this.plaque,
    required this.slug,
    required this.customer,
    this.customerPhone,
    this.broker,
    this.brokerPhone,
    required this.containerPrice,
    this.containerCityID,
    this.containerType,
    this.status,
    this.containerInformationC,
    this.containerOtherDetails,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.containerRelatedExpenses,
  });

  factory Conteneure.fromJson(Map<String, dynamic> json) {
    return Conteneure(
      id: json['id'],
      name: json['container_name'],
      plaque: json['plaque'],
      slug: json['slug'],
      customer: json['customer'],
      customerPhone: json['customer_phone']?.toString(),
      broker: json['broker'],
      brokerPhone: json['broker_phone']?.toString(),
      containerPrice: json['container_price']?.toDouble() ?? 0.0,
      containerCityID:
          json['container_city_id'], // Garder comme une chaîne de caractères
      containerType: json['container_type'],
      status: json['Status'],
      containerInformationC: json['container_information_c'],
      containerOtherDetails: json['container_other_details'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      containerRelatedExpenses:
          (json['container_related_expenses'] as List<dynamic>)
              .map((item) => Expense.fromJson(item))
              .toList(),
    );
  }
}
