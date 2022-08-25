import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rentapp/controllers/auth_controller.dart';
import 'package:rentapp/main.dart';
import 'package:rentapp/views/authentication/background.dart';
import 'package:rentapp/views/authentication/register.dart';
import 'package:rentapp/views/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx((() => LoadingOverlay(
          isLoading: authController.loading.value,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Background(
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2661FA),
                              fontSize: 36),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text(
                          "Forgot your password?",
                          style:
                              TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              bool signIn = await authController
                                  .signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);
                              if (signIn) {
                                Get.to(MyHomePage());
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: size.width * 0.5,
                            decoration: new BoxDecoration(
                              color: Color(0xFF7033FF),
                              borderRadius: BorderRadius.circular(80.0),
                              // gradient: new LinearGradient(
                              //   colors: [
                              //     Color.fromARGB(255, 255, 136, 34),
                              //     Color.fromARGB(255, 255, 177, 41)
                              //   ]
                              // )
                            ),
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()))
                          },
                          child: Text(
                            "Don't Have an Account? Sign up",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2661FA)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          //widget.toggleView();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DonorOrOrg()));
                          // signInWithGoogle();
                          // dynamic result = await _auth.signInWithGoogle();
                          // if (result != null) {
                          //   print('user registration is : ${result.uid}');
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(5)),
                          height: 45,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/images/google.png')),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await _auth.loginWithFacebook();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AdminHome()));
                        },
                        child: Container(
                          height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  height: 30,
                                  color: Colors.white,
                                  image:
                                      AssetImage('assets/images/facebook.png')),
                              Text(
                                'Sign in with Facebook',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )));
  }
}
