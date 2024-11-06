import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/app_controller.dart';
import 'package:todo_app/controller/custom_switch.dart';
import 'package:todo_app/pages/taskDescription.dart';
import 'package:todo_app/pages/todo_home.dart';
import 'package:todo_app/controller/task_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String filter = "All";
  String key = "Search";
  String value = "Search Result";
  String activeButton = "";

  @override
  void initState() {
    super.initState();
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskManager.loadTasks(); // Carregar tarefas no início
  }

  @override
  Widget build(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context);

    // Filtra as tarefas de acordo com o filtro selecionado
    List todoListToShow;
    if (filter == "Completed") {
      todoListToShow =
          taskManager.todoList.where((task) => task[1] == true).toList();
    } else if (filter == "Uncompleted") {
      todoListToShow =
          taskManager.todoList.where((task) => task[1] == false).toList();
    } else {
      todoListToShow = taskManager.todoList;
    }

    // Filtra com base na busc
    String searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      todoListToShow = todoListToShow
          .where((task) => task[0].toLowerCase().contains(searchQuery))
          .toList();
      _searchController.clear();
    } else {
      _searchController.clear();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppController.instance.isDartTheme
                    ? const Color.fromARGB(255, 21, 20, 20)
                    : Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        centerTitle: false,
        toolbarHeight: 190.h,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),

        /* actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSwitch(),
          ),
        ], */
        
        title: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Today",
                      style: GoogleFonts.raleway(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: AppController.instance.isDartTheme
                               ? Colors.white
                               : Colors.black,
                      ),
                    ),
                  ),

                  CustomSwitch(),
                ],
              ),
          
              
              SizedBox(width: 210.w),
              //CustomSwitch(),
          
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Best platform for creating to-do list",
                  style: GoogleFonts.raleway(
                    fontSize: 10.sp,
                    color: AppController.instance.isDartTheme
                         ? Colors.grey.shade100
                         : Colors.grey.shade800,
                  ),
                ),
              ),
          
              SizedBox(
                height: 30.h,
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.raleway(
                        color:  AppController.instance.isDartTheme
                                 ? Colors.white
                                 : Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppController.instance.isDartTheme
                                 ? Colors.grey.shade900
                                 : Colors.grey.shade300,
                        
                        hintText: "  Search task",
                        hintStyle: GoogleFonts.raleway(
                          color: AppController.instance.isDartTheme
                                 ? Colors.grey.shade400
                                 : Colors.grey.shade500,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.5.r),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchQuery = _searchController.text;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: AppController.instance.isDartTheme
                            ? Colors.white
                            : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            filter = "All";
                            activeButton = "All";
                          });
                        },
          
                        style: ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(60.w, 25.h)),
                          side: WidgetStateProperty.all(
                            BorderSide(color: Colors.transparent),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(0, 161, 154, 1),
                          ),
                        ),
          
                        child: AutoSizeText(
                          "All",
                          minFontSize: 10.sp,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          stepGranularity: 1.sp,
                          style: GoogleFonts.raleway(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
          
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            filter = "Completed";
                            activeButton = "Completed";
                          });
                        },
          
                        style: ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(110.w, 25.h)),
                          side: WidgetStateProperty.all(
                            BorderSide(
                              color: activeButton == "Completed"
                                  ? Colors.transparent
                                  : Color.fromRGBO(0, 161, 154, 1),
                            ),
                          ),
          
                          backgroundColor: WidgetStatePropertyAll(
                            activeButton == "Completed"
                                ? Color.fromRGBO(0, 161, 154, 1)
                                : Colors.transparent,
                          ),
          
                          foregroundColor: WidgetStatePropertyAll(
                            activeButton == "Completed"
                                ? Colors.white
                                : Color.fromRGBO(0, 161, 154, 1),
                          ),
                        ),
          
                        child: AutoSizeText(
                          minFontSize: 8.sp,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          stepGranularity: 1.sp,
                          "Completed",
                          style: GoogleFonts.raleway(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
          
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            filter = "Uncompleted";
                            activeButton = "Uncompleted";
                          });
                        },
          
                        style: ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(120.w, 25.h)),
                          side: WidgetStateProperty.all(
                            BorderSide(
                              color: activeButton == "Uncompleted"
                                  ? Colors.transparent
                                  : Colors.red,
                            ),
                          ),
          
                          backgroundColor: WidgetStatePropertyAll(
                            activeButton == "Uncompleted"
                                ? Colors.red
                                : Colors.transparent,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            activeButton == "Uncompleted"
                                ? Colors.white
                                : Colors.red,
                          ),
                        ),
          
                        child: AutoSizeText(
                          "Uncompleted",
                          minFontSize: 8.sp,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          stepGranularity: 1.sp,
                          style: GoogleFonts.raleway(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
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

      ),
      body: Column(
        children: [
          SizedBox(height: 20.w),
          Expanded(
            child: todoListToShow.isEmpty
                ? Center(
                    child: Text(
                      "Nenhuma tarefa encontrada",
                      style: GoogleFonts.raleway(
                        fontSize: 20.sp,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoListToShow.length,
                    itemBuilder: (context, index) {
                      String taskName = todoListToShow[index][0];
                      bool isCompleted = todoListToShow[index][1];
                      String taskDescription = todoListToShow[index][2];
                      String dateTime = todoListToShow[index][3];

                      return TodoHome(
                        taskName: taskName,
                        taskDescription: taskDescription,
                        isCompleted: isCompleted,
                        dateTime: dateTime,
                        index: index,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDescription(
                taskNameController: _taskNameController,
                taskDescriptionController: _taskDescriptionController,
                onPressed: () {
                  taskManager.addTask(_taskNameController.text,
                      _taskDescriptionController.text);
                  _taskDescriptionController.clear();
                  _taskNameController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        backgroundColor: Color.fromRGBO(0, 161, 154, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
