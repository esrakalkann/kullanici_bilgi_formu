import 'package:flutter/material.dart';
import 'package:user_info_form/models/user_form_model.dart';
import 'package:user_info_form/screens/form_summary_screen.dart';
import 'package:user_info_form/theme/app_theme.dart';

class FormScreen extends StatefulWidget {
    final UserModel? user;
  const FormScreen({super.key,this.user});
  
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _amount = '';
  String _gender = 'female';
  bool _isAgreed = false;
  bool _notificationsEnabled = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isAgreed) {
      _formKey.currentState!.save();

      final userModel = UserModel(
        fullName: _fullName,
        amount: _amount,
        gender: _gender,
        isAgreed: _isAgreed,
        notificationsEnabled: _notificationsEnabled,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InfoSum(user: userModel)),
      );

      print("Form sent: ${userModel.fullName}");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all the required fields and accept the terms and conditions.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcı Bilgileri")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(

            children: [
             
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  //hintText: 'What do people call you?',
                  labelText: 'İsim Soyisim *',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  _fullName = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen isim ve soyisminizi giriniz';
                  }
                  final words = value.trim().split(' ');
                  if (words.length < 2) {
                    return 'Lütfen isim ve soyisminizi giriniz';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 16),
              //Flutterdocs Widget TextFormField üzerindeki örnek ile
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Miktar *',
                  icon: Icon(Icons.money_sharp),
                  hintText:
                      'Lütfen çekmek istediğiniz miktarı giriniz',
                ),
                onSaved: (String? value) {
                  _amount = value ?? '';
                },

                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen miktar giriniz';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Lütfen geçerli bir miktar';
                  }
                  return null;
                },
              ),
   const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Gender"),
                
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'female', child: Text('Kadın'),),
                  
                  DropdownMenuItem(value: 'male', child: Text('Erkek')),
                  DropdownMenuItem(value: 'other', child: Text('Diğer')),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value ?? 'female';
                    
                  });
                  
                },
              ),
               const SizedBox(height: 16),
              //CheckboxListTile içinde validator kullanılamaz çünkü CheckboxListTile doğrudan bir FormField widget’ı değildir.
              CheckboxListTile(
                title: const Text("Sözleşmeyi kabul ediyorum"),
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Kaydet"),
              ),

              SwitchListTile(
                title: const Text("Bildirimlere izin ver"),
                value: _notificationsEnabled,
                
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
                    activeColor: AppTheme.secondaryColor,
                    secondary: const Icon(Icons.notifications_active),
                    
              ),
            ],
          ),
        ),
      ),
    );
  }
}
