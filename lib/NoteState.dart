 import 'Notemodel.dart';

abstract class NoteState{}

 class InitialState extends NoteState{}
 class IsloadingState extends NoteState{}
 class IsLoadedState extends NoteState{
  List<NoteModel> arrData;
  IsLoadedState({required this.arrData});
 }
 class ErrorLoadingState extends NoteState{
  String errorMessage;
  ErrorLoadingState({required this.errorMessage});
 }