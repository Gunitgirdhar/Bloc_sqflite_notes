
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_branch/Adding%20Data.dart';
import 'package:sqflite_branch/NoteCubit.dart';
import 'package:sqflite_branch/NoteState.dart';
import 'Appdatabase.dart';
//import 'Notemodel.dart';

void main() {
  runApp(BlocProvider(create: (context)=> CubitNotes(db: AppDataBase.db),child: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CubitNotes>().getAllNotes();
  }
  @override

  Widget build(BuildContext context) {
    context.read<CubitNotes>().getAllNotes();
    return Scaffold(
      body: BlocBuilder<CubitNotes,NoteState>(builder: (_, state) {
      if(state is IsloadingState){
        return Center(child: CircularProgressIndicator());
      }
      else if(state is ErrorLoadingState){
        return Center(
          child: Text(state.errorMessage),
        );
      }
      else if(state is IsLoadedState){
        return ListView.builder(
          itemCount: state.arrData.length,
          itemBuilder: (_, index) {
           return InkWell(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => AddingData(isUpdate: true,passtitle: state.arrData[index].title,passdesc: state.arrData[index].desc, newindex: state.arrData[index].note_id!),));
             },
             child: ListTile(
               leading: Text("${index+1}"),
               title: Text(state.arrData[index].title),
               subtitle: Text(state.arrData[index].desc),
               trailing: InkWell(
                 onTap: (){
                   context.read<CubitNotes>().deleteNotes(state.arrData[index].note_id!);
                 },
                 child: Icon(
                   Icons.delete
                 ),
               ),
             ),
           );
        },);
      }
      return Container(); // yeh isliye return kia kyunki block builder kehta hn ki agar else ya else if me koi bhiu condition nahi chali toh
        // ky areturn krenge toh es case me hum container return krenge
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddingData(),));
        },
        child: Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}


