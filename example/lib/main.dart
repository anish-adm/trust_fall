import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trust_fall/trust_fall.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool isJailBroken = false;
  bool canMockLocation = false;
  bool isRealDevice = true;
  bool isOnExternalStorage = false;
  bool isTrustFall = false;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
//    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await TrustFall.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    try{
      isJailBroken = await TrustFall.isJailBroken;
      canMockLocation = await TrustFall.canMockLocation;
      isRealDevice = await TrustFall.isRealDevice;
      isOnExternalStorage = await TrustFall.isOnExternalStorage;
      isTrustFall = await TrustFall.isTrustFall;
    }catch(error){
      print(error);
    }

    setState(() {
      isJailBroken = isJailBroken;
      canMockLocation = canMockLocation;
      isRealDevice = isRealDevice;
      isOnExternalStorage = isOnExternalStorage;
      isTrustFall = isTrustFall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device trust fall check'),
        ),
        body: Center(
          child: Card(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children:<Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('isJailBroken():'),
                       SizedBox(
                         width: 8,
                       ),
                       Text('${isJailBroken ? "Yes" : "No"}', style: TextStyle(fontWeight: FontWeight.w600),),
                     ],
                   ),
                   SizedBox(
                     height: 8,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('canMockLocation():'),
                       SizedBox(
                         width: 8,
                       ),
                       Text('${canMockLocation ? "Yes" : "No"}', style: TextStyle(fontWeight: FontWeight.w600),),
                     ],
                   ),
                   SizedBox(
                     height: 8,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('isRealDevice():'),
                       SizedBox(
                         width: 8,
                       ),
                       Text('${isRealDevice ? "Yes" : "No"}', style: TextStyle(fontWeight: FontWeight.w600),),
                     ],
                   ),
                   SizedBox(
                     height: 8,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('isOnExternalStorage():'),
                       SizedBox(
                         width: 8,
                       ),
                       Text('${isOnExternalStorage ? "Yes" : "No"}', style: TextStyle(fontWeight: FontWeight.w600),),
                     ],
                   ),SizedBox(
                     height: 8,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('isTrustFall():'),
                       SizedBox(
                         width: 8,
                       ),
                       Text('${isTrustFall ? "Yes" : "False"}', style: TextStyle(fontWeight: FontWeight.w600),),
                     ],
                   ),
                 ] ,
               ),

             ),
          ),
        ),
      ),
    );
  }
}
