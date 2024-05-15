class Order {
  final String symbol;
  final String type;
  final String side;
  final double quantity;
  final int creationTime;
  final double price;

  Order({
    required this.symbol,
    required this.type,
    required this.side,
    required this.quantity,
    required this.creationTime,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      symbol: json['symbol'] as String,
      type: json['type'] as String,
      side: json['side'] as String,
      quantity: json['quantity'] as double,
      creationTime: json['creation_time'] as int,
      price: json['price'] as double,
    );
  }
}
