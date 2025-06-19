import 'dart:io';

import 'package:chat_app/pages/desktop.dart';
import 'package:chat_app/pages/imbd.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceCheck extends StatelessWidget {
  const DeviceCheck({super.key});

bool isMobile(){
  if(kIsWeb){
    return defaultTargetPlatform == TargetPlatform.iOS ||defaultTargetPlatform == TargetPlatform.android;
  }
  else{
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }
}

  bool isDesktopPlatform() {
    if (kIsWeb) {
      return defaultTargetPlatform == TargetPlatform.macOS ||
             defaultTargetPlatform == TargetPlatform.windows ||
             defaultTargetPlatform == TargetPlatform.linux;
    } else {
      return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    }
  }
  @override
  Widget build(BuildContext context) {
    if(isMobile()){
      return Imbd();
    }
    else{
      return DesktopApp();
    }
  }
}