import 'package:flutter/services.dart';
import 'package:schoolapp/imports.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black));
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1361898587, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: "23f67d4d3fc0491f0687748e6b8a9e2b50dd1bbebcb1ec9e5c547e8523aae682", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'user_id',
        userName: 'user_name',
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),

    );
  }
}


