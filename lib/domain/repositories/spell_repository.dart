import 'package:dartz/dartz.dart';
import '../entities/spell.dart';
import '../../core/error/failures.dart';

abstract class SpellRepository {
  Future<Either<Failure, List<Spell>>> getAllSpells();
}