import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/taskDescription.dart';
import 'package:todo_app/utilities/todo_home.dart';
import 'package:todo_app/utilities/task_manager.dart';

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
  String key = "Search";
  String value = "Search Result";
  String activeButton = "";

  @override
  void initState() {
    super.initState();
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskManager.loadTasks();  // Carregar tarefas no início
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
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        toolbarHeight: 100.h,

        title: Expanded(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Today",
                  style: GoogleFonts.raleway(
                      fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Best platform for creating to-do list",
                  style: GoogleFonts.raleway(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              size: 25.w,
            ),
          )
        ],
      ),

      extendBody: true,
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(217, 218, 219, 0.619),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.grey,
                      hintText: "Search task",
                      hintStyle: GoogleFonts.raleway(
                        color: Colors.grey,
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
                    icon: Icon(Icons.search),
                  ),
              ],
            ),
          ),

          SizedBox(height: 15.w),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      filter = "All";
                      activeButton = "All";
                    });
                  },

                   style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(70.w, 25.h)),
                    side: WidgetStateProperty.all(
                      BorderSide(
                        color: Colors.transparent
                      ),
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
                      fontSize: 15.sp
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
                    fixedSize: WidgetStatePropertyAll(Size(120.w, 25.h)),
                    side: WidgetStateProperty.all(
                      BorderSide(
                        color: activeButton == "Completed"? Colors.transparent    : Colors.grey,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      activeButton == "Completed"? Color.fromRGBO(0, 161, 154, 1) : Colors.transparent,
                    ),

                    foregroundColor: WidgetStatePropertyAll(
                      activeButton == "Completed"? Colors.white : Color.fromRGBO(0, 161, 154, 1),
                    ),
                  ),

                  child: AutoSizeText(
                    minFontSize: 10.sp,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    stepGranularity: 1.sp,

                    "Completed",
                    style: GoogleFonts.raleway(
                      fontSize: 13.sp
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
                        color: activeButton == "Uncompleted"? Colors.transparent : Colors.grey,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      activeButton == "Uncompleted"? Colors.red : Colors.transparent,
                    ),

                    foregroundColor: WidgetStatePropertyAll(
                      activeButton == "Uncompleted" ? Colors.white : Colors.red,
                    ),
                  ),
                  child: AutoSizeText(
                    "Uncompleted",
                    minFontSize: 10.sp,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    stepGranularity: 1.sp,
                    style: GoogleFonts.raleway(
                      fontSize: 13.sp
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.w),

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
