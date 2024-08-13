import 'package:ar_visiting_app/layouts/ar_visit_layout.dart';
import 'package:ar_visiting_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool observebool= true;
  var testfieldkey= GlobalKey<FormState>();
  var arid= TextEditingController();
  var password= TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: testfieldkey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AVA REWASE VISIT',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 60,),

              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return ' please enter your ARID!';
                  }
                  return null;
                },
                controller: arid,
                decoration: InputDecoration(
                  labelText: 'E1C1FXXXNRX',

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: observebool,
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return ' please enter your password';
                  }
                  return null;
                },
                controller: password,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          observebool=!observebool;
                        });
                      } ,
                      icon: observebool?Icon(Icons.visibility):Icon(Icons.visibility_off)
                    ),
                    labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(height: 40,),
              DefualtButton(
                text: 'Login',
                height: 50,
                function: (){
                        if(testfieldkey.currentState!.validate()){
                        navigateandend(context, ArVisitLayout());
                      }
              },
                btncolor: Colors.amber),
            ],
          ),
        ),
      ),
    );
  }
}
