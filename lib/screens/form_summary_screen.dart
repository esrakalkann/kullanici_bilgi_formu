import 'package:flutter/material.dart';
import 'package:user_info_form/models/user_form_model.dart';
import 'package:user_info_form/screens/form_input_screen.dart';
import 'package:user_info_form/theme/app_theme.dart';

class InfoSum extends StatefulWidget {
  final UserModel user;
  const InfoSum({Key? key, required this.user}) : super(key: key);

  @override
  State<InfoSum> createState() => _InfoSumState();
}

class _InfoSumState extends State<InfoSum> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Form Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İsim Soyisim: ${user.fullName}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Miktar: ${user.amount}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Cinsiyet: ${user.gender}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Sözleşme: ${user.isAgreed ? "Kabul Edildi" : "Not Accepted"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.notifications, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Bildirim İzni: ${user.notificationsEnabled ? "Verildi" : "Verilmedi"}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Düzenle'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FormScreen(user: widget.user),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
