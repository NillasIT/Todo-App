// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/app_controller.dart';
import 'package:note/controller/task_manager.dart';
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

  // initState: Método chamado uma vez quando o estado é criado. Aqui:
  // taskManager: Acessa o gerenciador de tarefas sem escutar mudanças (não queremos que a UI se    atualize neste ponto).
  // Controladores de texto: Inicializa os controladores com o nome e a descrição da tarefa que estão sendo editados, retirando essas informações do taskManager com base no índice passado.
  @override
  void initState() {
    super.initState();
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskNameController = TextEditingController(text: taskManager.todoList[widget.index][0]);
    taskDescriptionController = TextEditingController(text: taskManager.todoList[widget.index][2]);
  }

  // dispose: Método chamado quando o estado é removido. Aqui, os controladores de texto são descartados para evitar vazamentos de memória.
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
      backgroundColor: AppController.instance.isDartTheme
                      ? const Color.fromARGB(255, 21, 20, 20)
                      : Colors.white,
      appBar: AppBar(
        //forceMaterialTransparency: true,
        toolbarHeight: ScreenUtil().setHeight(60),
        backgroundColor: AppController.instance.isDartTheme
                      ? const Color.fromARGB(255, 21, 20, 20)
                      : Colors.white,

        foregroundColor: AppController.instance.isDartTheme
                      ? Colors.white
                      : Colors.black,
        
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
                  color: AppController.instance.isDartTheme
                        ? Colors.white
                        : Colors.black,
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
                color: AppController.instance.isDartTheme
                        ? const Color.fromARGB(255, 51, 51, 51)
                        : const Color.fromARGB(255, 202, 201, 201),
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
                color: AppController.instance.isDartTheme
                        ? const Color.fromARGB(255, 51, 51, 51)
                        : const Color.fromARGB(255, 202, 201, 201),
              ),
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: taskDescriptionController,
                maxLines: 25,
              
                style: GoogleFonts.raleway(
                  fontSize: 14.sp,
                  color: AppController.instance.isDartTheme
                        ? Colors.grey.shade100
                        : Colors.grey.shade900,
                ),
                textAlign: TextAlign.justify,
                
                decoration: InputDecoration(
                  hintText: isNewTask
                            ? "Nota"
                            // ignore: dead_code
                            : null,
              
                  hintStyle: GoogleFonts.raleway(
                    fontSize: 14.sp,
                    color: AppController.instance.isDartTheme
                        ? Colors.grey.shade800
                        : Colors.grey.shade700,
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