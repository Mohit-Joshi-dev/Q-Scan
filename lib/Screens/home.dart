import 'package:q_scan/Const/const.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
// import 'package:admob_flutter/admob_flutter.dart';
// import 'package:flutter_app/admob_service.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'dart:io' show Platform;

import 'package:flutter/services.dart';

// import '../admob_service.dart';

const String testDevices = 'Mobileid';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScanResult scanResult;
  // final ams = AdmobServices();
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevices != null ? <String>[testDevices] : null,
  //   nonPersonalizedAds: true,
  //   keywords: <String>['Games', 'Anything', 'Business', 'work', 'home'],
  //   childDirected: false,
  // );
  // BannerAd _bannerAd;
  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       adUnitId: ams.getBannerAppId(),
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print('BannerAd : $event');
  //       });
  // }

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  // var _numberOfCameras = 0;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  bool result = false;

  IconData iconData = Icons.content_copy;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  // ignore: type_annotate_public_apis
  initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: ams.getAdmobAppId());
    // // _bannerAd = createBannerAd()
    // //   ..load()
    // //   ..show();
    // _bannerAd ??= createBannerAd();
    // _bannerAd
    //   ..load()
    //   ..show();
    // Admob.initialize(testDeviceIds: [ams.getAdmobAppId()]);
  }

  @override
  void dispose() {
    super.dispose();
    // _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget contentList = scanResult != null
        ? Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Result Type"),
                  subtitle: Text(scanResult.type?.toString() ?? ""),
                ),
                scanResult.rawContent.isEmpty
                    ? SizedBox(
                        height: 0,
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Data',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      scanResult.rawContent ?? "",
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Builder(builder: (context) {
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(iconData),
                                      ),
                                      onTap: () {
                                        ClipboardManager.copyToClipBoard(
                                            scanResult.rawContent);
                                        final snackBar = SnackBar(
                                          content: Text('Copied to Clipboard'),
                                          // action: SnackBarAction(
                                          //   label: 'Undo',
                                          //   onPressed: () {},
                                          // ),
                                        );

                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          iconData =
                                              iconData == Icons.content_copy
                                                  ? Icons.done
                                                  : Icons.content_copy;
                                        });
                                      },
                                    );
                                  }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                ListTile(
                  title: Text("Format"),
                  subtitle:
                      Text(scanResult.format.toString().toUpperCase() ?? ""),
                ),
                // ListTile(
                //   title: Text("Format note"),
                //   subtitle: Text(scanResult.formatNote ?? ""),
                // ),
              ],
            ),
          )
        : Text(
            'No Data',
          );

    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Q Scan',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: kPrimaryColor,
              actions: [
                // IconButton(
                //     icon: Icon(Icons.info_outline),
                //     onPressed: () {
                //       showAboutDialog(
                //         context: context,
                //         applicationName: 'Q - Scan',
                //         applicationIcon: Image.asset('assets/app_icon/icon.png'),
                //         applicationVersion: 'Version - 0.1',
                //       );
                //     })
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Q Scan',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'About Us',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Q - Scan',
                        applicationIcon:
                            Image.asset('assets/app_icon/icon.png'),
                        applicationVersion: 'Version - 0.1',
                      );
                    },
                  ),
                  // Ads
                  // AdmobBanner(
                  //     adUnitId: ams.getBannerAppId(),
                  //     adSize: AdmobBannerSize.FULL_BANNER)
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                  height: devHeight / 2.75,
                  width: devWidth,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                Container(
                  height: devHeight / 1.3,
                  margin: EdgeInsets.fromLTRB(20, 75, 20, 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      // scanResult != null ? showModelSheet(context) : Text(''),
                      scanResult != null
                          ? contentList
                          : Container(
                              height: devWidth / 2.5,
                              width: devWidth / 2.5,
                              child: Image.asset('assets/images/QRcode.png'),
                            ),

                      SizedBox(
                        height: 40,
                      ),
                      Center(child: buildInkWell()),
                      SizedBox(
                        height: 50,
                      ),
                      // AdmobBanner(
                      //     adUnitId: ams.getBannerAppId(),
                      //     adSize: AdmobBannerSize.FULL_BANNER)
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      onTap: scan,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor,
            // gradient: LinearGradient(
            //     colors: [Colors.white, kPrimaryColor, kPrimaryColor]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, blurRadius: 15, offset: Offset(2, 5))
            ]),
        child: Center(
          child: Text(
            'Scan',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  // Center buildIconButton() => Center(
  //       child: IconButton(
  //           icon: Icon(
  //             Icons.camera,
  //             size: 50,
  //             color: Colors.grey[600],
  //           ),
  //           tooltip: 'Scan',
  //           onPressed: scan),
  //     );

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: -1,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}

showModelSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      });
}
