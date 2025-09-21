import 'package:get_it/get_it.dart';
import '../../data/datasources/character_remote_data_source.dart';
import '../../data/datasources/spell_remote_data_source.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../data/repositories/spell_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/repositories/spell_repository.dart';
import '../../domain/usecases/get_all_characters.dart';
import '../../domain/usecases/get_students.dart';
import '../../domain/usecases/get_staff.dart';
import '../../domain/usecases/get_characters_by_house.dart';
import '../../domain/usecases/get_all_spells.dart';
import '../../presentation/cubits/character/character_cubit.dart';
import '../../presentation/cubits/spell/spell_cubit.dart';
import '../../network/rest_client.dart';
import '../services/tts_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<RestClient>(() => RestClient());
  getIt.registerLazySingleton<TTSService>(() => TTSService());

  getIt.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(restClient: getIt()),
  );
  getIt.registerLazySingleton<SpellRemoteDataSource>(
    () => SpellRemoteDataSourceImpl(restClient: getIt()),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<SpellRepository>(
    () => SpellRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => GetAllCharacters(getIt()));
  getIt.registerLazySingleton(() => GetStudents(getIt()));
  getIt.registerLazySingleton(() => GetStaff(getIt()));
  getIt.registerLazySingleton(() => GetCharactersByHouse(getIt()));
  getIt.registerLazySingleton(() => GetAllSpells(getIt()));

  getIt.registerFactory(
    () => CharacterCubit(
      getAllCharacters: getIt(),
      getStudents: getIt(),
      getStaff: getIt(),
      getCharactersByHouse: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SpellCubit(getAllSpells: getIt()),
  );
}