import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_branch/Appdatabase.dart';
import 'package:sqflite_branch/NoteState.dart';
import 'package:sqflite_branch/Notemodel.dart';

class CubitNotes extends Cubit<NoteState>{
  AppDataBase db;
  CubitNotes({required this.db}):super(InitialState());

  //adding Notes
void Addnotes(NoteModel newNote)async{

  emit(IsloadingState());

  bool check= await db.Addnote(newNote);

  if(check){
    var arrayData= await db.fetchNote();
    emit(IsLoadedState(arrData: arrayData));
  }
  else{
    emit(ErrorLoadingState(errorMessage: "Note is not loaded"));
  }
}
void getAllNotes()async{
  emit(IsloadingState());
  var data= await db.fetchNote();
  emit(IsLoadedState(arrData: data));
}

void deleteNotes(int index)async{
  var check=await db.deleteNote(index);
  if(check){
   getAllNotes();
  }
}
void upDatenotes(NoteModel updateNote)async{
  var check= await  db.updateNote(updateNote);
  if(check){
    getAllNotes();
  }
}
}