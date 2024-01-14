import 'package:flutter/material.dart';
import 'package:flutter_callender/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_callender/database/drift_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  // 아래의 언더스코어 클래스를 쓸 수 있게끔 부른다.
  // class LocalDatabase extends _$LocalDatabase {
  // LocalDatabase() : super(_openConnection());
  final database = LocalDatabase();

  print('------GET COLORS-------');
  print(await database.getCategoryColors());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
