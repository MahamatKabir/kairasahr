class Expense {
  int id;
  String article;
  double? paid;
  String? details;
  int? containerID;
  String? createdBy;
  String createdAt;
  String? updatedBy;
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
      paid: double.parse(json['paid'] ?? '0.0'),
      details: json['details'],
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
  Map<String, dynamic> toJson() {
    return {
      'label':
          label, // Utilisation de label ici, il peut être null, c'est correct
      'value': value,
    };
  }

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

  Map<String, dynamic> toJson() {
    return {
      'name':
          name, // Utilisation de label ici, il peut être null, c'est correct
      'value': value,
    };
  }

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
  final Type? type;
  final String? details;
  final Status? status;
  final String? createdBy;
  final String? createdAt;

  Expenses({
    required this.id,
    required this.article,
    required this.amountPaid,
    this.type,
    this.details,
    this.status,
    this.createdBy,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'article': article,
      'paid': amountPaid,
      'status': status?.toJson(),
      'type': type?.toJson(),
      'details': details,
      'created_by': createdBy,
      'created_at': createdAt,
    };
  }

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
