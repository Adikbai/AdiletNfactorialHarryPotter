import 'package:equatable/equatable.dart';
import '../../../domain/entities/spell.dart';

abstract class SpellState extends Equatable {
  const SpellState();

  @override
  List<Object?> get props => [];
}

class SpellInitial extends SpellState {}

class SpellLoading extends SpellState {}

class SpellLoaded extends SpellState {
  final List<Spell> spells;

  const SpellLoaded({required this.spells});

  @override
  List<Object?> get props => [spells];
}

class SpellError extends SpellState {
  final String message;

  const SpellError({required this.message});

  @override
  List<Object?> get props => [message];
}