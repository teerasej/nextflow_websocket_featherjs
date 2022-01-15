import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:flutter_feathersjs/src/helper.dart';
import 'package:nextflow_websocket_featherjs/annoucement_message.dart';
import 'package:nextflow_websocket_featherjs/message.dart';

void main() {
  runApp(const MyApp());
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
  FlutterFeathersjs flutterFeathersjs = FlutterFeathersjs()
    ..init(baseUrl: 'https://auction-websocket.ap.ngrok.io');

  StreamSubscription<FeathersJsEventData<AnnouncementMessage>>?
      streamSubscription;

  void _invokeWithFeatherPackage() async {
    try {
      var user = flutterFeathersjs.authenticate(
          userName: 'test01@gmail.com',
          password: '@AxTest01',
          strategy: 'local');
    } on FeatherJsError catch (e) {
      if (e.type == FeatherJsErrorType.IS_INVALID_CREDENTIALS_ERROR) {
        print('');
      } else if (e.type == FeatherJsErrorType.IS_INVALID_STRATEGY_ERROR) {
        print('');
      } else if (e.type == FeatherJsErrorType.IS_AUTH_FAILED_ERROR) {
        print('');
      }
    }

    var serviceName = 'api/auction_sequence_announcement';
    var messageResponse = await flutterFeathersjs.find(
      serviceName: serviceName,
      query: {
        'auction_sequence_id': 1,
      },
    );

    print(messageResponse);

    streamSubscription = flutterFeathersjs
        .listen<AnnouncementMessage>(
      serviceName: serviceName,
      fromJson: AnnouncementMessage.fromMap,
    )
        .listen((FeathersJsEventData<AnnouncementMessage> event) {
      // event is FeathersJsEventData<Message>
      // What event is sent by feathers js ?
      if (event.type == FeathersJsEventType.created) {
        // Trigger flutter_bloc event
        //add(FeatherCreatedMessageEvent(message: event));
        print('');
      } else if (event.type == FeathersJsEventType.removed) {
        print('');
      } else if (event.type == FeathersJsEventType.patched) {
        print('');
      }
    });
    // streamSubscription?.onData(
    //   (event) {
    //     // event is FeathersJsEventData<Message>
    //     // What event is sent by feathers js ?
    //     if (event.type == FeathersJsEventType.created) {
    //       // Trigger flutter_bloc event
    //       //add(FeatherCreatedMessageEvent(message: event));
    //       print('');
    //     } else if (event.type == FeathersJsEventType.removed) {
    //       print('');
    //     } else if (event.type == FeathersJsEventType.patched) {
    //       print('');
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(),
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
