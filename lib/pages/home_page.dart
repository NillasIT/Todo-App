import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/theme/custom_switch.dart';
import 'package:note/controller/task_manager.dart';
import 'package:note/pages/task_description.dart';
import 'package:note/pages/todo_home.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String filter = "All";
  String activeButton = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load tasks asynchronously
    Future.microtask(() {
      Provider.of<TaskManager>(context, listen: false).loadTasks().then((_) {
        setState(() {
          isLoading = false; // Set loading state to false after tasks are loaded
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context);

    // Filtra as tarefas de acordo com o filtro selecionado
    List<Map<String, dynamic>> todoListToShow;
    if (filter == "Completed") {
      todoListToShow =
          taskManager.completedTasks;
    } else if (filter == "Uncompleted") {
      todoListToShow =
          taskManager.uncompletedTasks;
    } else {
      // Mapear todoList para incluir índice original
      todoListToShow = taskManager.todoList
          .asMap()
          .entries
          .map((entry) => {'task': entry.value, 'index': entry.key})
          .toList();
    }

    // Filtra com base na busc
    String searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      todoListToShow = todoListToShow
      .where((task) => task['task'][0].toLowerCase().contains(searchQuery))
      .toList();
      _searchController.clear();
    } 

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today",
                    style: GoogleFonts.raleway(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        
               CustomSwitch(),
              ],
            ),
        
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Best platform for creating to-do list",
                style: GoogleFonts.raleway(
                  fontSize: 10.sp,
                  color: Colors.grey.shade500
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

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onTertiary,
                      
                      hintText: "  Search task",
                      hintStyle: GoogleFonts.raleway(
                        color: Theme.of(context).colorScheme.tertiary,
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
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
        
            SizedBox(height: 20.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                      fixedSize: WidgetStateProperty.all(Size(60.w, 25.h)),
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
          ],
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 20.w),
          Expanded(
            child: isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(0, 161, 154, 1)
                )
              )
              : todoListToShow.isEmpty
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
                      var taskData = todoListToShow[index];
                      List<dynamic> task = taskData['task'];
                      int originalIndex = taskData['index'];

                      String taskName = task[0];
                      bool isCompleted = task[1];
                      String taskDescription = task[2];
                      String dateTime = task[3];

                      return TodoHome(
                        taskName: taskName,
                        taskDescription: taskDescription,
                        isCompleted: isCompleted,
                        dateTime: dateTime,
                        index: originalIndex,
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
