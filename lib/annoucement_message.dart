class AnnouncementMessage {
  String? auctionSequenceId;
  String? annoucementText;

  AnnouncementMessage({this.auctionSequenceId, this.annoucementText});

  /// This is useful to deserialize this dart class
  /// As we cannot use the factory method
  static AnnouncementMessage fromMap(Map<String, dynamic> json) {
    return AnnouncementMessage.fromJson(json);
  }

  factory AnnouncementMessage.fromJson(Map<String, dynamic> json) {
    return AnnouncementMessage(
      auctionSequenceId: json['auction_sequence_id'],
      annoucementText: json["annoucement_text"],
    );
  }
}
