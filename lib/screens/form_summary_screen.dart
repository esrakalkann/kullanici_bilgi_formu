import 'package:flutter/material.dart';
import 'package:user_info_form/models/user_form_model.dart';
import 'package:user_info_form/screens/form_input_screen.dart';
import 'package:user_info_form/widgets/custom_button.dart';

class InfoSum extends StatelessWidget {
  final UserModel user;
  const InfoSum({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = user;
    return Scaffold(
      appBar: AppBar(title: const Text('Form Özeti')),
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
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                CustomButton(
                  text: 'Geri',
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back,
                  width: double.infinity,
                  height: 56,
                  isLoading: false,
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Düzenle',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FormInputScreen(initialData: user),
                        ),
                      );
                    },
                    icon: Icons.edit,
                    height: 56,
                    backgroundColor: const Color(0xFF2196F3),
                    isLoading: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Tamamla Butonu
            Center(
              child: CustomButton(
                text: 'Tamamla',
                onPressed: () {
                  _showCompletionDialog(context);
                },
                icon: Icons.check_circle,
                width: double.infinity,
                height: 56,
                backgroundColor: const Color(0xFF4CAF50),
                isLoading: false,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void _showCompletionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 28),
            SizedBox(width: 12),
            Text(
              'İşlem Tamamlandı',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          'Bilgileriniz başarıyla kaydedildi. Teşekkür ederiz!',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CustomButton(
            text: 'Tamam',
            onPressed: () {
              Navigator.of(context).pop(); // Dialog'u kapat
              Navigator.of(
                context,
              ).popUntil((route) => route.isFirst); // Ana ekrana dön
            },
            width: 100,
            height: 40,
            isLoading: false,
          ),
        ],
      );
    },
  );
}
