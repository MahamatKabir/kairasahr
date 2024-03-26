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

class Status {
  final String? label;
  final int value;

  Status({
    this.label,
    required this.value,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      label: json['label'],
      value: json['value'],
    );
  }
}

class Type {
  final String? name;
  final int? value;

  Type({
    this.name,
    this.value,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
      value: json['value'],
    );
  }
}

class Expenses {
  final int id;
  final String article;
  final double amountPaid;
  final Type type;
  final String? details;
  final Status status;
  final String? createdBy;
  final String? createdAt;

  Expenses({
    required this.id,
    required this.article,
    required this.amountPaid,
    required this.type,
    this.details,
    required this.status,
    this.createdBy,
    this.createdAt,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      article: json['article'],
      amountPaid: double.parse(json['paid']),
      status: Status.fromJson(json['status']),
      type: Type.fromJson(json['type']),
      details: json['details'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }
}
