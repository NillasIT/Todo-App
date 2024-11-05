// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDescription extends StatefulWidget {
  final taskNameController;
  final taskDescriptionController;
  final Function()? onPressed;

  const TaskDescription(
    {
      super.key, 
      required this.taskNameController, 
      required this.taskDescriptionController, 
      required this.onPressed,
    }
  );

  @override
  State<TaskDescription> createState() => _TaskDescriptionState();
}

class _TaskDescriptionState extends State<TaskDescription> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ScreenUtil().setHeight(60),
        backgroundColor: Color.fromRGBO(0, 161, 154, 1),
        foregroundColor: Colors.white,
        elevation: 7,

        title: Text(
          "Add task",
          style: GoogleFonts.raleway(
            fontSize: 25.sp, 
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: widget.onPressed, 
            
            icon: Icon(
              Icons.save_alt,
            )
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: widget.taskNameController,
                maxLines: 2,
              
                style: GoogleFonts.raleway(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              
                decoration: InputDecoration(
                  hintText: "Titulo da tarefa",
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 30.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.5.r),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                      
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.5.r),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Divider(),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Section/Content Description",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Divider(),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: widget.taskDescriptionController,
                maxLines: 12,
              
                style: GoogleFonts.raleway(
                  fontSize: 20.sp,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.justify,
                
                decoration: InputDecoration(
                  hintText: "Nota",
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 20.sp,
                    color: Colors.grey,
                  ),
              
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.5.r),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                      
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.5.r),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                ),
              
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}