import 'package:flutter/material.dart';
import 'package:user_info_form/models.dart/user_model.dart';
class InfoSum extends StatefulWidget {
  final UserModel user;
  const InfoSum({Key? key, required this.user}) : super(key: key);

  @override
  State<InfoSum> createState() => _InfoSumState();
}

class _InfoSumState extends State<InfoSum> {
  @override
  Widget build(BuildContext context) {
    final user=widget.user;
    return  Scaffold(
        appBar: AppBar(

          title: const Text('Form Summary'),
        ),
        body: Padding(padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name: ${user.fullName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: ${user.amount}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Gender: ${user.gender}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Agreement: ${user.isAgreed ? "Accepted" : "Not Accepted"}',
              style: const TextStyle(fontSize: 16),
        ),
        
        
          ],
        ),
      ),
   










    );
  }
}





