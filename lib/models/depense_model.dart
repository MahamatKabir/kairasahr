class Expense {
  int id;
  String article;
  String slug;
  int total;
  int paid;
  int containerID;
  int createdBy;
  String createdAt;
  int updatedBy;
  String updatedAt;

  Expense({
    required this.id,
    required this.article,
    required this.slug,
    required this.total,
    required this.paid,
    required this.containerID,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      article: json['article'],
      slug: json['slug'],
      total: json['total'],
      paid: json['paid'],
      containerID: json['containerID'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }
}
