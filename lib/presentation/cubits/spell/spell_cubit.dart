import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_all_spells.dart';
import '../../../core/usecases/usecase.dart';
import 'spell_state.dart';

class SpellCubit extends Cubit<SpellState> {
  final GetAllSpells getAllSpells;

  SpellCubit({required this.getAllSpells}) : super(SpellInitial());

  Future<void> loadAllSpells() async {
    emit(SpellLoading());
    final result = await getAllSpells(NoParams());
    result.fold(
      (failure) => emit(SpellError(message: failure.toString())),
      (spells) => emit(SpellLoaded(spells: spells)),
    );
  }
}