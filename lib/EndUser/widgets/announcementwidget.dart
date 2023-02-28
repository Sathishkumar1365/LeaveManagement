import 'package:flutter/material.dart';
import 'package:leavemanagement/EndUser/shared/AnnouncedItems.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/Admin/services/Admin_AddEmployee.dart';


Widget AnnouncementWidget(String id,String title,String description,String announced_image){

  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Hero(
            tag: '${title}',
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(announced_image),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.notes),
                        Container(
                          width:250,
                          child: Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(fontSize: 12,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Text(date,style: GoogleFonts.roboto(),)
                      ],
                    )
                  ],
                ),
          )
        ],
      ),
    ),
  );
}