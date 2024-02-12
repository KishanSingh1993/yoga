import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Screens/SplashScreen.dart';
import '../services/localdb.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hey I am using Yoga For Beginners App',
        text: 'Hey I am using Yoga For Beginners App. It has best yoga workout for all age groups. You should try it once.',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit:  BoxFit.cover,
                image: NetworkImage("https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80")
              )
            ),
          ),
          ListTile(
            title: Text("Reset Progress" , style: TextStyle(fontSize: 18),),
            leading: Icon(Icons.restart_alt_sharp , size: 25,),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('RESET PROGRESS'),
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
                    content: Text('This will reset all of your fitness data including Total Workout Time, Streak and Burned Calories. The action cannot be revert once done.'),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Cancel" , style: TextStyle(fontSize: 20),) ,style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 18 , horizontal: 35))),),
                      ElevatedButton(onPressed: () async{
await LocalDB.setWorkOutTime(0);
await LocalDB.setkcal(0);
await LocalDB.setStreak(0);
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                      }, child: Text("Reset" , style: TextStyle(fontSize: 20),) ,style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 18 , horizontal: 35))),)
                    ],
                  )
              );
            },
          ),
          ListTile(
            title: Text("Share With Friends" , style: TextStyle(fontSize: 18),),
            leading: Icon(Icons.share , size: 25,),
            onTap: shareApp ,
          ),
          ListTile(
            title: Text("Rate Us" , style: TextStyle(fontSize: 18),),
            leading: Icon(Icons.star , size: 25,),
            onTap: () async{
              await launchUrl(Uri.parse("https://play.google.com/store/apps/dev?id=5340688481594363532"));
            },
          ),

          ListTile(
            title: Text("Privacy Policy" , style: TextStyle(fontSize: 18),),
            leading: Icon(Icons.security , size: 25,),
            onTap: () async{

              // https://sites.google.com/view/yogaforbeginners-indianyoga/privacy-policy
              await launchUrl(Uri.parse("https://doc-hosting.flycricket.io/isro-app/9d79020c-0c05-435d-85b2-5f32d300cb6b/privacy"));

            },
          ),
          Divider(thickness: 2, endIndent: 30, indent: 30,),
          Text("Version 1.0.0" , style: TextStyle(fontWeight: FontWeight.bold),)

        ],
      ),
    );
  }
}
