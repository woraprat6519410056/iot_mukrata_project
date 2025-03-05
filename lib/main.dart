import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_mukrata_project/views/splash_screen_ui.dart';

void main() {
  runApp(
    IoTMukrataProject(),
  );
}

//------------------------------------------
class IoTMukrataProject extends StatefulWidget {
  const IoTMukrataProject({super.key});
  @override
  State<IoTMukrataProject> createState() => _IoTMukrataProjectState();
}

class _IoTMukrataProjectState extends State<IoTMukrataProject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
