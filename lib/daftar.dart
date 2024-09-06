import 'package:belajar_login_firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // method daftar
  Future<void> daftar() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordKontroller.text);

      if (mounted) {
        // Berhasil mendaftar, arahkan ke halaman login dan tampilkan SnackBar
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
        const snackBar = SnackBar(content: Text('Berhasil Mendaftar'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on FirebaseAuthException catch (e) {
      // Gunakan switch untuk menangani berbagai error dan tampilkan SnackBar
      switch (e.code) {
        case 'weak-password':
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password terlalu lemah.')),
            );
          }
          break;
        case 'email-already-in-use':
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email sudah digunakan.')),
            );
          }
          break;
        case 'invalid-email':
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Format email tidak valid.')),
            );
          }
          break;
        case 'operation-not-allowed':
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pendaftaran dinonaktifkan.')),
            );
          }
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: ${e.message}')),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Daftar'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
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
                        icon: Icon(_sembunyi
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                      label: const Text('Ulangi Password'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _sembunyi = !_sembunyi;
                          });
                        },
                        icon: Icon(_sembunyi
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                          daftar();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Daftar'),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
