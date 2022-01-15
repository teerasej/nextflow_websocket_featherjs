import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:flutter_feathersjs/src/helper.dart';
import 'package:nextflow_websocket_featherjs/annoucement_message.dart';
import 'package:nextflow_websocket_featherjs/auction_sequence_car_message.dart';
import 'package:nextflow_websocket_featherjs/message.dart';
import 'package:nextflow_websocket_featherjs/providers/auction_web_socket.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return AuctionWebSocketProvider();
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuctionWebSocketProvider? provider;

  void _invokeWithFeatherPackage() async {
    // test FeatherJSHelper
    FeatherjsHelper().setAccessToken(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2NDIyMzc3NTAsImV4cCI6MTY0NDgyOTc1MCwiYXVkIjoiaHR0cHM6Ly9hcGlkZXYuYXVjdGlvbmV4cHJlc3MuY28udGgiLCJpc3MiOiJmZWF0aGVycyIsInN1YiI6IjIiLCJqdGkiOiI2YWM3NWExNi0zMmRiLTQ1MmMtYjEwOC02M2M3M2NjMDdkZGQifQ.K2tDM350K-Z2_wWWXs8fl4Rf0vGD6ZBDnSycg8X9nkw');

    await provider?.connect();
    await provider?.subscribeStreamAnnouncment(1);
    await provider?.subscribeStreamAuctionSequenceCar(1);
  }

  @override
  Widget build(BuildContext context) {
    provider = context.read<AuctionWebSocketProvider>();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Selector<AuctionWebSocketProvider, String?>(
              selector: (_, provider) => provider.annoucementMessage,
              builder: (context, value, child) {
                if (value == null) value = '';
                return Text(value);
              },
            ),
            Selector<AuctionWebSocketProvider, AuctionSequenceCarMessage?>(
              selector: (_, provider) => provider.auctionSequenceCarMessage,
              builder: (context, value, child) {
                if (value == null) return Text('nothing here...');

                return Text(value.auctionStatus ?? 'null');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _invokeWithFeatherPackage,
            child: const Text('feather'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
