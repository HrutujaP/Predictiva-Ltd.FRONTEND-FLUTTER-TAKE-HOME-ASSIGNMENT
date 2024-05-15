class Portfolio {
  final double balance, profit;
  int assets, profitPercentage;
  bool isLoss;

  Portfolio({
    required this.balance,
    required this.assets,
    required this.profitPercentage,
    required this.profit,
    required this.isLoss,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    double val = double.parse(json['profit'].toString());
    bool loss = val < 0;

    return Portfolio(
      balance: double.parse(json['balance'].toString()),
      assets: int.parse(json['assets'].toString()),
      profitPercentage: int.parse(json['profit_percentage'].toString()),
      profit: val,
      isLoss: loss,
    );
  }
}
