import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/editTask.dart';
import 'package:todo_app/utilities/task_manager.dart';

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
                Container(
                  width: 330.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.5.r),
                    color: Color.fromRGBO(248, 247, 247, 1),

                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 200, 198, 198),
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
                          top: 60.h,
                          right: 15.w,
                        ),

                        child: Expanded(
                          child: Row(
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
                                    minFontSize: 14.sp,
                                    stepGranularity: 1.sp,
                                    maxLines: 1,
                                    style: GoogleFonts.raleway(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
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
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Divider(),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      taskManager.deleteTask(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 25.sp,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(right: 80.w),
                                child: Expanded(
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
                                        size: 25.sp,
                                      ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Expanded(
                                  child: Text(
                                    dateTime,
                                    style: GoogleFonts.raleway(
                                      color: Colors.grey,
                                      fontSize: 13.sp
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 330.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.5.r),
                        topRight: Radius.circular(15.5.r),
                      ),
                      color: Color.fromRGBO(0, 161, 154, 1)),
                ),
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
