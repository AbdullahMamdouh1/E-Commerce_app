



import 'package:abdullah1/widget/color.dart';
import 'package:flutter/material.dart';

class FromText extends StatelessWidget {
  final TextInputType TextInputTypeee;
  final bool ispassword;
  final String labelTextr;
  final  IconData prefixIconT ;
  final dynamic controllerr;
   final dynamic validator;
  final dynamic autovalidateMode;
  final   Widget suffixIconn ;
     var onChangedd ;

  FromText( {
    Key? key,
     required this.TextInputTypeee,
  required this.ispassword,
  required this.labelTextr, required this.prefixIconT, this.controllerr,this.validator,this.autovalidateMode,
     required this.suffixIconn,this.onChangedd


  } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
      autovalidateMode:autovalidateMode ,
      onChanged: onChangedd,
      //  mount char maxLength:3,


      validator: validator,
      controller:controllerr,

      keyboardType: TextInputTypeee,
      obscureText:ispassword,
      decoration: InputDecoration(focusColor: purple,
          labelStyle: TextStyle(

              fontSize:13,
               ),
          labelText: labelTextr,

          prefixIcon:Icon(prefixIconT,color: Colors.black45,) ,

           suffixIcon: suffixIconn ,

          // to delete bordwes
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.black26),

          borderRadius: BorderRadius.circular(30)
          ),errorBorder: OutlineInputBorder(borderSide: BorderSide(
            style: BorderStyle.solid, color: Colors.red),borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: purple, ),
              borderRadius: BorderRadius.circular(30),

          ),focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(
              style: BorderStyle.solid, color: Colors.red),borderRadius: BorderRadius.circular(30),),
          fillColor: Colors.white,
          filled: true),
    );
  }
}