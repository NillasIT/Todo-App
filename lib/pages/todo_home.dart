import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/app_controller.dart';
import 'package:note/controller/task_manager.dart';
import 'package:note/pages/edit_task.dart';
import 'package:provider/provider.dart';

class TodoHome extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool isCompleted;
  final String dateTime;
  final int index;

  const TodoHome(
    {
      super.key,
      required this.taskName,
      required this.taskDescription,
      required this.isCompleted,
      required this.dateTime,
      required this.index,
   }
  );

  
  @override
  Widget build(BuildContext context) {

    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onLongPress:() {
                    ////////////
                  },
                  child: Container(
                    width: 330.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.5.r),
                      color: AppController.instance.isDartTheme
                            ? Colors.grey.shade900
                            : Colors.grey.shade100,
                  
                      boxShadow: [
                        BoxShadow(
                          color: AppController.instance.isDartTheme
                                ? const Color.fromARGB(255, 8, 8, 8)
                                : Colors.grey.shade400,
                  
                          offset: Offset(4.w, 8.h),
                          blurRadius: 20.r,
                          spreadRadius: 1.r,
                        ),
                      ],
                    ),
                  
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15.w,
                            top: 10.h,
                            right: 15.w,
                          ),
                  
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) => EditTask(
                                          index: index, 
                                          
                                        )
                                      ),
                                    );
                                  },
                                            
                                  child: AutoSizeText(
                                    taskName,
                                    overflow: TextOverflow.ellipsis,
                                    //minFontSize: 14.sp,
                                    //stepGranularity: 1.sp,
                                    maxLines: 1,
                                    style: GoogleFonts.raleway(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppController.instance.isDartTheme
                                            ? Colors.white
                                            : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(
                                width: 10.w,
                              ),
                                            
                              GestureDetector(
                                onTap: () {
                                  taskManager.checkBox(index);
                                },
                                            
                                child: Container(
                                  width: 15.w,
                                  height: 15.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCompleted
                                          ? Colors.blue
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2.w,
                                      ),
                                  ),
                                            
                                  child: isCompleted
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12.sp,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                  
                        SizedBox(
                          height: 5.h,
                        ),
                  
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Divider(
                            color: AppController.instance.isDartTheme
                                ? const Color.fromARGB(255, 51, 51, 51)
                                : Colors.grey.shade300,
                          ),
                        ),
                  
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                  
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Text(
                                  dateTime,
                                  style: GoogleFonts.raleway(
                                    color: AppController.instance.isDartTheme
                                        ? const Color.fromARGB(255, 195, 194, 194)
                                        : const Color.fromARGB(255, 84, 82, 82),
                                            
                                    fontSize: 16.sp
                                  ),
                                ),
                              ),
                              SizedBox(width: 55.w,),
                  
                              Padding(
                                padding: EdgeInsets.only(left: 1.w),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) => EditTask(
                                        index: index, 
                                        
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20.sp,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                  
                              Padding(
                                padding: EdgeInsets.only(left: 1.w),
                                child: IconButton(
                                  onPressed: () {
                                    taskManager.deleteTask(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /* Container(
                  width: 330.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.5.r),
                        topRight: Radius.circular(15.5.r),
                      ),
                      color: Color.fromRGBO(0, 161, 154, 1)),
                ), */
              ],
            ),
            SizedBox(
              height: 20.w,
            )
          ],
        );
      },
    );
  }
}
