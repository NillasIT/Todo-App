// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/features/controller/task_manager.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final int index;

  const EditTask(
    {
      super.key, 
      required this.index, 
    }
  );

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController taskNameController = TextEditingController();
  late TextEditingController taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskNameController = TextEditingController(text: taskManager.todoList[widget.index][0]);
    taskDescriptionController = TextEditingController(text: taskManager.todoList[widget.index][2]);
  }

  // * Dispose: Método chamado quando o estado é removido. Aqui, os controladores de texto são descartados para evitar vazamentos de memória.
  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  void saveTask() {
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskManager.updateTask(widget.index, taskNameController.text, taskDescriptionController.text);
    Navigator.pop(context);
  }

  @override

  Widget build(BuildContext context) {
    bool isNewTask = true;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        //forceMaterialTransparency: true,
        toolbarHeight: ScreenUtil().setHeight(60),
        backgroundColor: Theme.of(context).colorScheme.surface,
        
        elevation: 0,
        title: Text(
          "Edit task",
          style: GoogleFonts.raleway(
            fontSize: 25.sp, 
            fontWeight: FontWeight.bold,
          ),
        ),

        
        actions: [
          IconButton(
            onPressed: () { 
              saveTask();
            }, 
            icon: Icon(
              Icons.edit,
              size: 20.w,
              color: Colors.amber,
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
                controller: taskNameController,
                
                style: GoogleFonts.raleway(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              
                decoration: InputDecoration(
                  hintText: isNewTask
                            ? "Titulo da tarefa"
                            // ignore: dead_code
                            : null,
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 20.sp,
                    color: Colors.grey.shade700,
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
                controller: taskDescriptionController,
                maxLines: 25,
              
                style: GoogleFonts.raleway(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSecondaryFixed
                ),
                textAlign: TextAlign.justify,
                
                decoration: InputDecoration(
                  hintText: isNewTask
                            ? "Nota"
                            // ignore: dead_code
                            : null,
              
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