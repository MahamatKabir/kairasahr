class Containere {
  int id;
  String name;
  String slug;
  String customer;
  String customerTel;
  int cityID;
  int contTypeID;
  int status;
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
    required this.cityID,
    required this.contTypeID,
    required this.status,
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
      cityID: json['cityID'],
      contTypeID: json['contTypeID'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }
}
