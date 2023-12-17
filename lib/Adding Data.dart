import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_branch/NoteCubit.dart';
import 'package:sqflite_branch/Notemodel.dart';

class AddingData extends StatelessWidget {
  var controller1=TextEditingController();
  var controller2=TextEditingController();
  String? passtitle;
  String? passdesc;
  int? newindex;
  bool? isUpdate;

  AddingData({this.passtitle,this.passdesc,this.newindex,this.isUpdate=false});
  String buttontitle="Add Note";

  void upDateControlers(){
    controller1.text=passtitle!;
    controller2.text=passtitle!;
        buttontitle="Update Note";
  }

  @override
  Widget build(BuildContext context) {
    if(isUpdate!){
     upDateControlers();
    }

    return Scaffold(
      body: Column(
        children: [
          TextField(controller: controller1,),
          SizedBox(height: 10,),
          TextField(
            controller: controller2,
          ),
          ElevatedButton(onPressed: (){
            var title=controller1.text.toString();
            var desc=controller2.text.toString();
            if(isUpdate!){
              context.read<CubitNotes>().upDatenotes(NoteModel(title: title, desc: desc ,note_id: newindex));
            }
            else{
              context.read<CubitNotes>().Addnotes(NoteModel(title: title, desc: desc ));
            }

            Navigator.pop(context);
          }, child: Text("Update"))
        ],
      ),
    );
  }
}
