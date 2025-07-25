import 'package:flutter/material.dart';
import 'package:user_info_form/models.dart/user_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _amount = '';
  String _gender = 'female';
  bool _isAgreed = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isAgreed) {
      _formKey.currentState!.save();

      final userModel = UserModel(
        fullName: _fullName,
        amount: _amount,
        gender: _gender,
        isAgreed: _isAgreed,
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
      appBar: AppBar(title: const Text("Form Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  //icon: Icon(Icons.person),
                  //hintText: 'What do people call you?',
                  labelText: 'Full Name *',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              //Flutterdocs Widget TextFormField üzerindeki örnek ile
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount *',
                  hintText:
                      'Please enter the amount of money you want to withdraw',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Gender"),
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value ?? 'female';
                  });
                },
              ),

              CheckboxListTile(
                title: const Text("I agree to the terms and conditions"),
                value: _isAgreed,
                onChanged: (value) {
                    setState(() { 
                      _isAgreed = value ?? false;

                });
              },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
