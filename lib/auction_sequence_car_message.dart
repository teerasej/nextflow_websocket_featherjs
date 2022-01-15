import 'package:nextflow_websocket_featherjs/auction_activity.dart';

class AuctionSequenceCarMessage {
  String? auctionSequenceId;
  String? annoucementText;

  DateTime? dateNow;
  DateTime? startDate;
  DateTime? endDate;
  int? nextAuctionSequenceCarId;
  int? startPrice;
  int? currentPrice;
  int? winnerId;
  bool? isLessThanReservePrice;
  String? auctionStatus;

  List<AuctionActivity>? auctionActivities = [];

  AuctionSequenceCarMessage(
      {this.dateNow,
      this.startDate,
      this.endDate,
      this.nextAuctionSequenceCarId,
      this.startPrice,
      this.currentPrice,
      this.winnerId,
      this.isLessThanReservePrice,
      this.auctionStatus});

  /// This is useful to deserialize this dart class
  /// As we cannot use the factory method
  static AuctionSequenceCarMessage fromMap(Map<String, dynamic> json) {
    return AuctionSequenceCarMessage.fromJson(json);
  }

  factory AuctionSequenceCarMessage.fromJson(Map<String, dynamic> json) {
    var _dateNow = null;
    var _startDate = null;
    var _endDate = null;
    if (json['date_now'] != null) {
      _dateNow = DateTime.parse(json['date_now']);
    }

    if (json['start_date'] != null) {
      _startDate = DateTime.parse(json['start_date']);
    }

    if (json['end_date'] != null) {
      _endDate = DateTime.parse(json['end_date']);
    }
    return AuctionSequenceCarMessage(
      dateNow: _dateNow,
      startDate: _startDate,
      endDate: _endDate,
      nextAuctionSequenceCarId: json['next_auction_sequence_car_id'],
      startPrice: json['start_price'],
      currentPrice: json['current_price'],
      winnerId: json['winner_id'] ?? 0,
      isLessThanReservePrice: json['is_less_then_reserve_price'],
      auctionStatus: json['auction_status'],
    );
  }
}
