import 'package:belajar_login_firebase/login.dart';
import 'package:flutter/material.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _emailController = TextEditingController();
  final _passwordKontroller = TextEditingController();
  final _konfirmasiPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sembunyi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Daftar'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text('Masukkan email'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordKontroller,
                  decoration: InputDecoration(
                    label: const Text('Masukkan password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _sembunyi = !_sembunyi;
                        });
                      },
                      icon: Icon(
                          _sembunyi ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: _sembunyi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _konfirmasiPassword,
                  decoration: InputDecoration(
                    label: Text('Ulangi Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _sembunyi = !_sembunyi;
                        });
                      },
                      icon: Icon(
                          _sembunyi ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: _sembunyi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'konfirmasi Password tidak boleh kosong';
                    }

                    if (value != _passwordKontroller.text) {
                      return 'konfirmasi Password tidak sesuai';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Daftar'),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
