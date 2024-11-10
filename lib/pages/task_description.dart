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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: ScreenUtil().setHeight(60),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,

        title: Text(
          "Create new task",
          style: GoogleFonts.raleway(
            fontSize: 25.sp, 
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: widget.onPressed, 
            
            icon: Icon(
              Icons.save_rounded,
              size: 20.w,
              color: Color.fromRGBO(0, 161, 154, 1),
            ),
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
              
                style: GoogleFonts.raleway(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              
                decoration: InputDecoration(
                  hintText: "Titulo da tarefa",
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 20.sp,
                    color: Colors.grey.shade600,
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
              child: Divider(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Section/Content Description",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 161, 154, 1),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Divider(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: widget.taskDescriptionController,
                maxLines: 25,
              
                style: GoogleFonts.raleway(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSecondaryFixed
                ),
                textAlign: TextAlign.justify,
                
                decoration: InputDecoration(
                  hintText: "Nota",
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onTertiaryFixed,
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