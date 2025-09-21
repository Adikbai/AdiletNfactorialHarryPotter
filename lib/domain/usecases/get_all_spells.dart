import 'package:dartz/dartz.dart';
import '../entities/spell.dart';
import '../repositories/spell_repository.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';

class GetAllSpells implements UseCase<List<Spell>, NoParams> {
  final SpellRepository repository;

  GetAllSpells(this.repository);

  @override
  Future<Either<Failure, List<Spell>>> call(NoParams params) async {
    return await repository.getAllSpells();
  }
}