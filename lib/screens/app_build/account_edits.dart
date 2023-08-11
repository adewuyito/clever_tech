import 'package:clever_tech/data/colors.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({super.key});

  Widget _profilePhoto(){
    return Container(
      height: 95,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('Profile photo',style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -.41,
            )),
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/image_a.jpg'),
          ),
          const SizedBox(width: 16,),
          Icon(Icons.arrow_forward_ios_rounded, color: colorGrey3,),
        ],
      ),
    );
  }

  Widget _profileName(){

    const String name = 'Timothy';

    return Container(
      height: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('Profile photo', style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -.41,
            ),),
          ),
          Text(name, style: TextStyle(
              fontSize: 13,
              letterSpacing: -0.08,
              color: colorGrey2
          ),),
          const SizedBox(width: 16,),
          Icon(Icons.arrow_forward_ios_rounded, color: colorGrey3,),
        ],
      ),
    );
  }

  Widget _profileTime(){

    const String name = 'Not Set';

    return Container(
      height: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('Time zone', style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -.41,
            ),),
          ),
          Text(name, style: TextStyle(
              fontSize: 13,
              letterSpacing: -0.08,
              color: colorGrey2
          ),),
          const SizedBox(width: 16,),
          Icon(Icons.arrow_forward_ios_rounded, color: colorGrey3,),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Account'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'SFTS',
          fontSize: 17,
          color: colorBlack2,
        ),
        leading: IconButton(
          onPressed: () { Navigator.of(context).pop();},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 17, left: 17),
        child: Column(
          children: [
            _profilePhoto(),
            const SizedBox(height: 16,),
            _profileName(),
            const SizedBox(height: 16,),
            _profileTime(),
          ],
        ),
      ),
    );
  }
}