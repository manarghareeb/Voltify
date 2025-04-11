import 'package:cloud_firestore/cloud_firestore.dart';

class HomeDataModel {
  final double balance;
  final double electricity;
  final DateTime renewalDate;

  HomeDataModel({
    required this.balance,
    required this.electricity,
    required this.renewalDate,
  });

  factory HomeDataModel.fromMap(Map<String, dynamic> map) {
    return HomeDataModel(
      balance: (map['balance'] as num?)?.toDouble() ?? 0.0,
      electricity: (map['electricity'] as num?)?.toDouble() ?? 0.0,
      renewalDate: (map['renewalDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'electricity': electricity,
      'renewalDate': Timestamp.fromDate(renewalDate),
    };
  }

  HomeDataModel copyWith({
    double? balance,
    double? electricity,
    DateTime? renewalDate,
  }) {
    return HomeDataModel(
      balance: balance ?? this.balance,
      electricity: electricity ?? this.electricity,
      renewalDate: renewalDate ?? this.renewalDate,
    );
  }
}