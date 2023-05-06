import 'package:flutter/material.dart';

import '../authen.dart';
import 'custom_textfield.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = ['Login', 'Forgot password', 'Register'];
  final btnContent = ['Login', 'Next', 'Next'];
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  int selectedIndex = 0;
  // @override
  // void initState() {
  //   selectedIndex = 0;
  // }
  void resetInput() {
    userNameController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  void showSnackBar(display) {
    final snackBar = SnackBar(content: Text(display));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void Authentication() {
    String userName = userNameController.text.trim();
    String password = passwordController.text.trim();

    String confirmPassword;
    if (userName.length == 0) {
      showSnackBar('Tên đăng nhập không được để trống');
      return;
    }

    if (selectedIndex == 0) {
      if (userName == Authen.username && password == Authen.password) {
        showSnackBar('Đăng nhập thành công');
        return;
      }
    }

    confirmPassword = confirmPasswordController.text.trim();
    if (selectedIndex == 1 || selectedIndex == 2) {
      if (password != confirmPassword) {
        showSnackBar('Mật khẩu xác nhận không khớp');
        return;
      }
    }
    if (selectedIndex == 1) {
      if (userName != Authen.username) {
        showSnackBar('Không tìm thấy tài khoản');
        return;
      }
      Authen.password = password;
      setState(() {
        resetInput();
        selectedIndex = 0;
      });
      return;
    }
    Authen.password = password;
    Authen.username = userName;
    setState(() {
      resetInput();
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
        child: Column(
          children: [
            Text(title[selectedIndex],
                style: TextStyle(fontSize: 20, color: Colors.blue)),
            CustomTextField(
              hintText: 'Username',
              controller: userNameController,
            ),
            CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true),
            selectedIndex != 0
                ? CustomTextField(
                    hintText: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPasswordController)
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text(btnContent[selectedIndex]),
                onPressed: () {
                  Authentication();
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: (selectedIndex == 0)
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Text(
                      'Forgot Password? |',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Text('Register',
                          style: TextStyle(color: Colors.redAccent)))
                ])
              : Row()),
    );
  }
}
