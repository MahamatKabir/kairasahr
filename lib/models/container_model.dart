import 'package:kairasahrl/models/depense_model.dart'; // Assurez-vous d'importer correctement la classe Expense

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
  String? containerCityID;
  String? containerType;
  String? status;
  String? containerInformationC;
  String? containerOtherDetails;
  String createdBy;
  String createdAt;
  String? updatedBy;
  String? updatedAt;
  List<Expense>?
      containerRelatedExpenses; // Liste des dépenses associées au conteneur

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
    // Convertir la liste des dépenses à partir des données JSON

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
      containerCityID: json['container_city_id'],
      containerType: json['container_type_id'],
      status: json['status'],
      containerInformationC: json['container_information_c'],
      containerOtherDetails: json['container_other_details'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      containerRelatedExpenses:
          (json['container_related_expenses'] as List<dynamic>?)
              ?.map((item) => Expense.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'container_name': name,
      'plaque': plaque,
      'slug': slug,
      'customer': customer,
      'customer_phone': customerPhone,
      'broker': broker,
      'broker_phone': brokerPhone,
      'container_price': containerPrice,
      'container_city_id': containerCityID,
      'container_type_id': containerType,
      'status': status,
      'container_information_c': containerInformationC,
      'container_other_details': containerOtherDetails,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'container_related_expenses': containerRelatedExpenses
          ?.map((expense) => expense.toJson())
          .toList(), // Convertit chaque dépense en JSON
    };
  }
}
