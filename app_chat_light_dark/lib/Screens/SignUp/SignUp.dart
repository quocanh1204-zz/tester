import 'dart:async';
import 'package:app_chat_light_dark/Auth/auth.dart';
import 'package:app_chat_light_dark/Screens/Home/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController =new TextEditingController();
  final _emailController = new TextEditingController();
  final _passController = new TextEditingController();
  final _phoneController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();

  String _password = '';
  String _confirmPassword = '';
  void addData(String name, String pass, String email, String phone) {
    databaseRef.push().set({
      'name': name,
      'Số điện thoại': phone,
      'Mật khẩu': pass,
      'Gmail': email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                  child: Text('Sign Up',
                      style: GoogleFonts.pangolin(fontSize: 36)))),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Tài khoản',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Bắt buộc điền thông tin';
                }
                if (value.trim().length < 7) {
                  return 'Tài khoản không thể dưới 7 chữ';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  labelText: 'Email'),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                // Check if the entered email has the right format
                if (!RegExp(
                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  labelText: "Số Điện Thoại",
                  hintText: "Số điện thoại của bạn"),
              validator: validateMobile,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextFormField(
              controller: _passController,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Hãy nhập mật khẩu',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
              obscureText: true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Trường hợp này bắt buộc';
                }
                if (value.trim().length < 8) {
                  return 'Mật khẩu không thể dưới 8 chữ';
                }
                return null;
              },
              onChanged: (value) => _password = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Xác nhận lại mật khẩu',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Trường hợp này bắt buộc';
                }

                if (value != _password) {
                  return 'Mật khẩu xác nhận không khớp với mật khẩu đã nhập';
                }

                return null;
              },
              onChanged: (value) => _confirmPassword = value,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: RaisedButton(
             onPressed: (){
                addData(_nameController.text, _emailController.text,
                    _passController.text, _phoneController.text);
              },
              child: Text(
                "Signup",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Color(0xff3277D8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
            ),
          ),
        ],
      ),
    );
  }
}
