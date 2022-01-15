class AuctionWebSocketUtil {
  static String endpoint = 'https://auction-websocket.ap.ngrok.io';

  static AuctionWebSocket get auctionWebSocket {
    return AuctionWebSocket();
  }
}

class AuctionWebSocket {
  String auctionSequenceCar =
      '${AuctionWebSocketUtil.endpoint}/api/auction_sequence_car';

  String serviceNameAuctionSequenceAnnouncement =
      'api/auction_sequence_announcement';

  String get auctionSequenceAnnouncement {
    return '${AuctionWebSocketUtil.endpoint}/$serviceNameAuctionSequenceAnnouncement';
  }

  String auctionSequenceAnnouncementWithId(int sequenceId) {
    return '$auctionSequenceAnnouncement?auction_sequence_id=$sequenceId';
  }
}
