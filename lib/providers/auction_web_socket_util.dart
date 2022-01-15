class AuctionWebSocketUtil {
  static String endpoint = 'https://auction-websocket.ap.ngrok.io';

  static AuctionWebSocket get auctionWebSocket {
    return AuctionWebSocket();
  }
}

class AuctionWebSocket {
  String serviceNameAuctionSequenceAnnouncement =
      'api/auction_sequence_announcement';

  String serviceNameAuctionSequenceCar = 'api/auction_sequence_car';

  String get auctionSequenceAnnouncement {
    return '${AuctionWebSocketUtil.endpoint}/$serviceNameAuctionSequenceAnnouncement';
  }

  String get auctionSequenceCar {
    return '${AuctionWebSocketUtil.endpoint}/$serviceNameAuctionSequenceCar';
  }

  String auctionSequenceAnnouncementWithId(int sequenceId) {
    return '$auctionSequenceAnnouncement?auction_sequence_id=$sequenceId';
  }

  String auctionSequenceCarWithId(int sequenceId) {
    return '$auctionSequenceCar?auction_sequence_car_id=$sequenceId';
  }
}
