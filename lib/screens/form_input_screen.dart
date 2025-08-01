import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user_form_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_text_field.dart';
import 'form_summary_screen.dart';

class FormInputScreen extends StatefulWidget {
  final UserModel? initialData;

  const FormInputScreen({super.key, this.initialData});

  @override
  State<FormInputScreen> createState() => _FormInputScreenState();
}

class _FormInputScreenState extends State<FormInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  String _fullName = '';
  String _amount = '';
  String _gender = 'Erkek';
  bool _isAgreed = false;
  bool _notificationsEnabled = false;

  final List<String> _genderOptions = ['Erkek', 'Kadın', 'Diğer'];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _fullName = widget.initialData!.fullName;
      _amount = widget.initialData!.amount;  
      _gender = widget.initialData!.gender;
      _isAgreed = widget.initialData!.isAgreed;
      _notificationsEnabled = widget.initialData!.notificationsEnabled;
      _nameController.text = _fullName;
      _amountController.text = _amount;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'İsim-Soyisim boş bırakılamaz';
    }
    if (value.length < 2) {
      return 'En az 2 karakter giriniz';
    }
    if (!RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$').hasMatch(value)) {
      return 'Sadece harf ve boşluk girebilirsiniz';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Para miktarı giriniz';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Geçerli bir sayı giriniz';
    }
    if (number <= 0) {
      return 'Miktar 0\'dan büyük olmalı';
    }
    if (value.length > 6) {
      return 'En fazla 6 haneli sayı girebilirsiniz';
    }
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cinsiyet seçimi yapınız';
    }
    return null;
  }

  void _onSubmit() {
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
          content: Text("Lütfen tüm gerekli alanları doldurun ve sözleşmeyi kabul edin."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Kullanıcı Bilgileri', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF2196F3),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // İsim-Soyisim
                CustomTextField(
                  label: 'İsim-Soyisim',
                  hint: 'Adınızı ve soyadınızı giriniz',
                  controller: _nameController,
                  validator: _validateName,
                  keyboardType: TextInputType.numberWithOptions(),
                 // prefixIcon: const Icon(Icons.person, color: Color(0xFF2196F3)),
                  onSaved: (value) {
                    _fullName = value ?? '';
                  },
                ),

                const SizedBox(height: 24),

                // Para Miktarı
                CustomTextField(
                  label: 'Para Miktarı (TL)',
                  hint: 'Çekmek istediğiniz miktarı giriniz',
                  controller: _amountController,
                  validator: _validateAmount,
                  keyboardType: TextInputType.number,
                 // inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                  //prefixIcon: const Icon(Icons.monetization_on, color: Color(0xFF2196F3)),
                  onSaved: (value) {
                    _amount = value ?? '';
                  },
                ),

                const SizedBox(height: 24),

                // Cinsiyet Dropdown
                CustomDropdown(
                  label: 'Cinsiyet',
                  hint: 'Cinsiyetinizi seçiniz',
                  value: _gender,
                      items: _genderOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                //  items: _genderOptions,
                //  validator: _validateGender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value ?? 'Erkek';
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Sözleşme Checkbox
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey)),
                  child: CheckboxListTile(
                    title: const Text('Sözleşmeyi kabul ediyorum', style: TextStyle(fontSize: 16)),
                    value: _isAgreed,
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF4CAF50),
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),

                const SizedBox(height: 24),

                // Bildirim Switch
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey)),
                  child: SwitchListTile(
                    title: const Text('Bildirim İzni', style: TextStyle(fontSize: 16)),
                    subtitle: Text(_notificationsEnabled ? 'Bildirimler açık' : 'Bildirimler kapalı', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF4CAF50),
                    secondary: Icon(_notificationsEnabled ? Icons.notifications_active : Icons.notifications_off, color: const Color(0xFF2196F3)),
                  ),
                ),

                const SizedBox(height: 40),

                // İleri Butonu
                CustomButton(text: 'İleri', onPressed: _onSubmit, icon: Icons.arrow_forward, width: double.infinity, height: 56, isLoading: false,),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}