import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:nextflow_websocket_featherjs/providers/auction_web_socket_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../annoucement_message.dart';
import 'auction_web_socket_util.dart';

class AuctionWebSocketProvider extends ChangeNotifier {
  FlutterFeathersjs flutterFeathersjs = FlutterFeathersjs()
    ..init(baseUrl: AuctionWebSocketUtil.endpoint);

  StreamSubscription<FeathersJsEventData<AnnouncementMessage>>?
      streamSubscriptionAnnouncement;
  String? annoucementMessage = '';

  Future<void> connect({String token = ''}) async {
    var _token;

    if (token.isNotEmpty) {
      _token = token;
    } else {
      _token = await FeatherjsHelper().getAccessToken();
    }

    try {
      var helper = FeatherjsHelper();
      helper.setAccessToken(
        token: _token,
      );

      var isAuthenticate = await flutterFeathersjs.scketio.authWithJWT();
    } on FeatherJsError catch (e) {
      if (e.type == FeatherJsErrorType.IS_INVALID_CREDENTIALS_ERROR) {
        print('${e.message}');
      } else if (e.type == FeatherJsErrorType.IS_INVALID_STRATEGY_ERROR) {
        print('${e.message}');
      } else if (e.type == FeatherJsErrorType.IS_AUTH_FAILED_ERROR) {
        print('${e.message}');
      }
    }
  }

  void streamAuctionSequenceCar() {}

  Future<void> subscribeStreamAnnouncment(int auctionSquenceId) async {
    var serviceName = AuctionWebSocketUtil
        .auctionWebSocket.serviceNameAuctionSequenceAnnouncement;

    // establish connection
    var messageResponse = await flutterFeathersjs.find(
      serviceName: serviceName,
      query: {
        'auction_sequence_id': 1,
      },
    );

    // what if cannot subscribe

    // subscribe
    streamSubscriptionAnnouncement = flutterFeathersjs
        .listen<AnnouncementMessage>(
      serviceName: serviceName,
      fromJson: AnnouncementMessage.fromMap,
    )
        .listen((FeathersJsEventData<AnnouncementMessage> event) {
      // event is FeathersJsEventData<Message>
      // What event is sent by feathers js ?
      if (event.type == FeathersJsEventType.patched) {
        annoucementMessage = event.data?.annoucementText;
        notifyListeners();
      }
      // else if (event.type == FeathersJsEventType.removed) {
      //   print('');
      // } else if (event.type == FeathersJsEventType.created) {
      //   print('');
      // }
    });
  }

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
