import 'package:flutter/material.dart';
import 'package:user_info_form/screens/form_input_screen.dart';
import 'package:user_info_form/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilgi Formu',
      theme: AppTheme.lightTheme,
      home: const FormInputScreen(),
    );
  }
}
