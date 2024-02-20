class Containere {
  int id;
  String name;
  String slug;
  String customer;
  int customerTel;
  String? broker;
  int? brokerTel;
  double? amount;
  int cityID;
  int contTypeID;
  int status;
  String newC;
  String contDetails;
  String? createdBy;
  String createdAt;
  String? updatedBy;
  String? updatedAt;

  Containere({
    required this.id,
    required this.name,
    required this.slug,
    required this.customer,
    required this.customerTel,
    this.broker,
    this.brokerTel,
    this.amount,
    required this.cityID,
    required this.contTypeID,
    required this.status,
    required this.newC,
    required this.contDetails,
    this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Containere.fromJson(Map<String, dynamic> json) {
    return Containere(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      customer: json['customer'],
      customerTel: json['customerTel'],
      broker: json['broker'],
      brokerTel: json['brokerTel'],
      amount: json['amount'],
      cityID: json['cityID'],
      contTypeID: json['contTypeID'],
      status: json['status'],
      newC: json['newC'],
      contDetails: json['cont_Details'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }
}
