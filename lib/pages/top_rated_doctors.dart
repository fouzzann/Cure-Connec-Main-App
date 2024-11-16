import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatedDoctors extends StatelessWidget {
   TopRatedDoctors({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(   backgroundColor:  Color(0xFFF5F5F5),
    
    appBar: PreferredSize(preferredSize: Size(0, 80),
      child: AppBar(
       leading: Padding(
       padding: const EdgeInsets.only(top:18),
         child: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
       ),
        backgroundColor:  Colors.white, 
        title: Padding(
          padding: const EdgeInsets.only(top:18),
          child: Text('Top Rated Doctors',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
        ),
        centerTitle: true,
      ),
    ),
    
    );
  }
}