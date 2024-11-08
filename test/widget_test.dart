import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note/controller/app_controller.dart';
import 'package:note/controller/task_manager.dart';
import 'package:note/main.dart';
import 'package:note/pages/edit_task.dart';
import 'package:note/pages/home_page.dart';
import 'package:note/pages/task_description.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('Testa inicialização e widgets principais', (WidgetTester tester) async {
    // Inicializa os provedores
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskManager()),
          ChangeNotifierProvider(create: (_) => AppController())
        ],
        child: MyApp(),
      ),
    );

    // Verifica se a página HomePage é carregada
    expect(find.byType(HomePage), findsOneWidget);

    // Verifica a presença do FloatingActionButton
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Testa adição de tarefa', (WidgetTester tester) async {
    // Inicializa os provedores
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskManager()),
          ChangeNotifierProvider(create: (_) => AppController())
        ],
        child: MyApp(),
      ),
    );

    // Verifica se a página HomePage é carregada
    expect(find.byType(HomePage), findsOneWidget);

    // Verifica o botão de adicionar tarefa
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verifica se a página TaskDescription é carregada
    expect(find.byType(TaskDescription), findsOneWidget);

    // Insere o título e descrição da tarefa
    await tester.enterText(find.byType(TextField).at(0), 'Nova Tarefa');
    await tester.enterText(find.byType(TextField).at(1), 'Descrição da Nova Tarefa');
    
    // Salva a nova tarefa
    await tester.tap(find.byIcon(Icons.save_rounded));
    await tester.pumpAndSettle();

    // Verifica se a nova tarefa foi adicionada na página inicial
    expect(find.text('Nova Tarefa'), findsOneWidget);
  });

  testWidgets('Testa edição de tarefa', (WidgetTester tester) async {
    // Inicializa os provedores
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskManager()),
          ChangeNotifierProvider(create: (_) => AppController())
        ],
        child: MyApp(),
      ),
    );

    // Verifica se a página HomePage é carregada
    expect(find.byType(HomePage), findsOneWidget);

    // Simula a tarefa existente e entra na página de edição
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verifica se a página EditTask é carregada
    expect(find.byType(EditTask), findsOneWidget);

    // Atualiza o título e descrição da tarefa
    await tester.enterText(find.byType(TextField).at(0), 'Tarefa Editada');
    await tester.enterText(find.byType(TextField).at(1), 'Descrição Editada');

    // Salva as alterações
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verifica se a tarefa foi atualizada na página inicial
    expect(find.text('Tarefa Editada'), findsOneWidget);
  });

  testWidgets('Testa remoção de tarefa', (WidgetTester tester) async {
    // Inicializa os provedores
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskManager()),
          ChangeNotifierProvider(create: (_) => AppController())
        ],
        child: MyApp(),
      ),
    );

    // Verifica se a página HomePage é carregada
    expect(find.byType(HomePage), findsOneWidget);

    // Simula a tarefa existente e remove
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verifica se a tarefa foi removida da página inicial
    expect(find.text('Tap plus to add new task'), findsNothing);
  });
}



/* // This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/app_controller.dart';
import 'package:todo_app/controller/task_manager.dart';

import 'package:todo_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskManager()),
        ChangeNotifierProvider(create: (_) => AppController()),
      ],
      child: MyApp(),
    ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
 */