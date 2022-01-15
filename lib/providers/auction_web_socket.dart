import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:nextflow_websocket_featherjs/providers/auction_web_socket_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../annoucement_message.dart';
import 'auction_web_socket_util.dart';

class AuctionWebSocketProvider extends ChangeNotifier {
  Future<void> auctionSequenceCar(
    int auctionSequenceId,
    int auctionSequenceCarId,
    int price,
  ) async {
    var jsonForAuction = {
      'auction_sequence_id': auctionSequenceId,
      'auction_sequence_car_id': auctionSequenceCarId,
      'price': price,
    };

    try {
      // var response = await Dio().post(
      //   AuctionWebSocketUtil().auctionWebSocket.auctionSequenceCar,
      //   data: jsonForAuction,
      //   options: Options(
      //     headers: {
      //       'Authorization':
      //           'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2NDE4OTM4MDUsImV4cCI6MTY0NDQ4NTgwNSwiYXVkIjoiaHR0cHM6Ly9hcGlkZXYuYXVjdGlvbmV4cHJlc3MuY28udGgiLCJpc3MiOiJmZWF0aGVycyIsInN1YiI6IjMiLCJqdGkiOiI0OTUzZTdkYy01MzY1LTRjMWUtYTdlZi00NDU2MzU3MzY3M2IifQ.avtz0vJJx01RTITcK09uqNtL_mBbukjANg2pPLc5Qxg',
      //     },
      //   ),
      // );

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
