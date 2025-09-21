import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_all_characters.dart';
import '../../../domain/usecases/get_students.dart';
import '../../../domain/usecases/get_staff.dart';
import '../../../domain/usecases/get_characters_by_house.dart';
import '../../../core/usecases/usecase.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetAllCharacters getAllCharacters;
  final GetStudents getStudents;
  final GetStaff getStaff;
  final GetCharactersByHouse getCharactersByHouse;

  CharacterCubit({
    required this.getAllCharacters,
    required this.getStudents,
    required this.getStaff,
    required this.getCharactersByHouse,
  }) : super(CharacterInitial());

  Future<void> loadAllCharacters() async {
    emit(CharacterLoading());
    final result = await getAllCharacters(NoParams());
    result.fold(
      (failure) => emit(CharacterError(message: failure.toString())),
      (characters) => emit(CharacterLoaded(characters: characters)),
    );
  }

  Future<void> loadStudents() async {
    emit(CharacterLoading());
    final result = await getStudents(NoParams());
    result.fold(
      (failure) => emit(CharacterError(message: failure.toString())),
      (characters) => emit(CharacterLoaded(characters: characters)),
    );
  }

  Future<void> loadStaff() async {
    emit(CharacterLoading());
    final result = await getStaff(NoParams());
    result.fold(
      (failure) => emit(CharacterError(message: failure.toString())),
      (characters) => emit(CharacterLoaded(characters: characters)),
    );
  }

  Future<void> loadCharactersByHouse(String house) async {
    emit(CharacterLoading());
    final result = await getCharactersByHouse(HouseParams(house: house));
    result.fold(
      (failure) => emit(CharacterError(message: failure.toString())),
      (characters) => emit(CharacterLoaded(characters: characters)),
    );
  }
}