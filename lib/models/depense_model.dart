class Expense {
  int id;
  String article;
  int? paid;
  String? details;
  int? containerID;
  int createdBy;
  String createdAt;
  int? updatedBy;
  String? updatedAt;

  Expense({
    required this.id,
    required this.article,
    this.paid,
    this.details,
    this.containerID,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      article: json['article'],
      paid: json['paid'],
      details: json['details'],
      containerID: json['containerID'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'article': article,
      'details': details,
      'paid': paid,
      'containerID': containerID,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
    };
  }
}

class Expenses {
  final int id;
  final String article;
  final double amountPaid;
  final String expenseType;
  final String createdBy;
  final String createdAt;
  final String type;
  final String details;

  Expenses({
    required this.id,
    required this.article,
    required this.amountPaid,
    required this.expenseType,
    required this.createdBy,
    required this.createdAt,
    required this.type,
    required this.details,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      article: json['Article'],
      amountPaid: double.parse(json['Payé']),
      expenseType: json['Type de la Dépense'] ?? 'Non spécifié',
      createdBy: json['Creer Par'],
      createdAt: json['Date de Création'],
      type: json['Type'] ?? 'Non spécifié',
      details: json['Détails'] ?? 'Non spécifié',
    );
  }
}
