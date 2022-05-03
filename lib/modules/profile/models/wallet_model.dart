class WalletModel {
  final double amount;

  WalletModel({required this.amount});

  factory WalletModel.fromJson({required Map<String, dynamic> map}) {
    return WalletModel(amount: map["amount"]);
  }
}
