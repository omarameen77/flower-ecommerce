// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> requestPermissions() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     // هنا بنستغل المتغير عشان نعرف حالة الموافقة
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('عاش! المستخدم وافق على صلاحيات الفايربيز.');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('المستخدم وافق على صلاحيات مؤقتة (Provisional).');
//     } else {
//       print('المستخدم رفض إعطاء صلاحية الإشعارات.');
//     }

//     // التأكيد على صلاحية الأندرويد 13 يدويًا
//     if (await Permission.notification.isDenied) {
//       await Permission.notification.request();
//     }
//   }

//   // 2. تهيئة الإشعارات المحلية (عشان تظهر والتطبيق مفتوح Foreground)
//   Future<void> initLocalNotifications() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); // أيقونة الإشعار

//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: DarwinInitializationSettings(),
//     );

//     await _localNotifications.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // هنا الكود اللي هيتنفذ لما المستخدم يضغط على الإشعار
//       },
//     );
//   }

//   // 3. الاستماع للإشعارات القادمة
//   void listenToNotifications() {
//     // أ: والتطبيق مفتوح في الـ Foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;

//       if (notification != null && android != null) {
//         // بنعرض الإشعار محلياً لأن فايربيز أوتوماتيك مبيظهروش والتطبيق مفتوح
//         _localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'flower_channel_id', // ID القناة
//               'Flower Notifications', // اسم القناة
//               importance: Importance.max,
//               priority: Priority.high,
//             ),
//           ),
//         );
//       }
//     });

//     // ب: لما المستخدم يضغط على الإشعار والتطبيق شغال في الـ Background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("المستخدم فتح التطبيق من الإشعار: ${message.notification?.title}");
//     });
//   }

//   // 4. الحصول على الـ Device Token (عشان لو هتبعث لإشعار لشخص معين من الـ Backend)
//   Future<String?> getDeviceToken() async {
//     String? token = await _messaging.getToken();
//     print("Device Token: $token");
//     return token;
//   }
// }
