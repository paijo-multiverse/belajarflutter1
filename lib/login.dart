import 'package:belajar_login_firebase/daftar.dart';
import 'package:belajar_login_firebase/lupa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sembunyi = true;

  // method login
  Future<void> masuk() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordkController.text);

      // Periksa apakah widget masih terpasang (mounted)
      if (mounted) {
        const snackBar = SnackBar(content: Text('Berhasil horee'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on FirebaseAuthException catch (e) {
      // Menggunakan switch untuk menangani error berdasarkan kode error
      switch (e.code) {
        case 'invalid-email':
          if (mounted) {
            const snackBar = SnackBar(content: Text('Email tidak valid.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case 'user-disabled':
          if (mounted) {
            const snackBar =
                SnackBar(content: Text('Akun pengguna dinonaktifkan.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case 'user-not-found':
          if (mounted) {
            const snackBar =
                SnackBar(content: Text('Pengguna tidak ditemukan.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case 'wrong-password':
          if (mounted) {
            const snackBar = SnackBar(content: Text('APassword salah.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        default:
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Terjadi kesalahan: ${e.message}')),
            );
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Login'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text('Email')),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordkController,
                  decoration: InputDecoration(
                    label: const Text('Password'),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        masuk();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Masuk'),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Lupa(),
                          ),
                        );
                      },
                      child: const Text('Lupa password ?'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Masuk dengan google'),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun ?'),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Daftar()));
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
