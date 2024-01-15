import 'package:flutter/material.dart';
import 'package:flutter_contact_appss/contact_service.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});
  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  //inisialisasi variabel
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hobby = TextEditingController();

  //inisialisasi class
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Tambah Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          // key adalah kunci unik untuk mengidentifikasi suatu form
          // di bawah key ini tambahkan widget sesuai selera kalian
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
              //bentuk dropdown select dengan dua pilihan
              DropdownButtonFormField<String>(
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
                decoration: InputDecoration(labelText: ' Nomor Handphone'),
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
                  //jika validasi berhasil maka jalankan perintah di bawahnya
                  //jika tidak maka tampilkan pesan kesalahan di tiap formnya
                  if (_formKey.currentState!.validate()) {
                    contactService.saveData(
                      name.text,
                      gender.text,
                      email.text,
                      phone.text,
                      address.text,
                      hobby.text,
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) =>
                          false, // Ini akan menghapus semua halaman sebelumnya dari tumpukan navigasi.
                    );
                  }
                },
                child: Text('Add Data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
