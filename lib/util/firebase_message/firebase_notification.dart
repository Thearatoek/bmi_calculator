import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {
  final _firebaseMessage = FirebaseMessaging.instance;

  //Initial firebase Message
  Future<void> initialNotification() async {
    await _firebaseMessage.requestPermission();
    final fCMToken = await _firebaseMessage.getToken();
    print('Token : $fCMToken');
  }
}
