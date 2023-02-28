import 'package:flutter/material.dart';


class UserNotify extends StatefulWidget {
  const UserNotify({Key? key}) : super(key: key);

  @override
  State<UserNotify> createState() => _UserNotifyState();
}

class _UserNotifyState extends State<UserNotify> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index){
           return Row(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   child: CircleAvatar(
                       backgroundColor: Colors.white,
                       radius: 30,
                       child:CircleAvatar(
                         backgroundImage: NetworkImage("https://img.freepik.com/premium-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg?w=2000"),
                         radius: 28,
                       )
                   ),
                 ),
               ),
               SizedBox(width: 2,),
               Container(
                 width: 200,
                 child: Row(
                   children: [
                     Column(
                       children: [
                         Text('Your emergency leave is \napproved by the admin',overflow: TextOverflow.ellipsis,)
                       ],
                     )
                   ],
                 ),

               )


             ],
           );
        }

    );
  }
}
