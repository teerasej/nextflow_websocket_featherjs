class AuctionActivity {
  int? price;
  int? userId;
  DateTime? createdAt;

  AuctionActivity({this.price, this.userId, this.createdAt});

  /// This is useful to deserialize this dart class
  /// As we cannot use the factory method
  static AuctionActivity fromMap(Map<String, dynamic> json) {
    return AuctionActivity.fromJson(json);
  }

  factory AuctionActivity.fromJson(Map<String, dynamic> json) {
    return AuctionActivity(
      price: json['price'],
      userId: json['user_id'],
      createdAt: DateTime.parse(
        json['created_at'],
      ),
    );
  }
}
