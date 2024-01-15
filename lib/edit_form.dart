import 'package:flutter/material.dart';
import 'package:flutter_contact_appss/contact_service.dart';

class EditForm extends StatefulWidget {
  final Map<dynamic, dynamic> data;

  EditForm({required this.data});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hobby = TextEditingController();

  ContactService contactService = ContactService();

  @override
  void initState() {
    super.initState();

    initializeControllers();
  }

  void initializeControllers() {
    name.text = widget.data['name']!;
    gender.text = widget.data['gender']!;
    email.text = widget.data['email']!;
    phone.text = widget.data['phone']!;
    address.text = widget.data['address']!;
    hobby.text = widget.data['hobby']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Update Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Nama';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: gender.text,
                items: ['Laki-Laki', 'Perempuan'].map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gender.text = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Handphone'),
                controller: phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Nomor Handphone';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                controller: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Alamat';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hobi'),
                controller: hobby,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Hobi';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    contactService.updateData(
                        name.text,
                        gender.text,
                        email.text,
                        phone.text,
                        address.text,
                        hobby.text,
                        widget.data['id']);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text('Update Data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
