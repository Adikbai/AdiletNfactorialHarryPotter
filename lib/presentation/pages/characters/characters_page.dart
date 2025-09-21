import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_adilet/core/theme/app_colors.dart';
import 'package:harry_potter_adilet/core/theme/text_styles.dart';
import 'package:harry_potter_adilet/presentation/widgets/main_loading.dart';
import '../../../presentation/cubits/character/character_cubit.dart';
import '../../../presentation/cubits/character/character_state.dart';
import '../../../domain/entities/character.dart';
import '../../../core/di/service_locator.dart';
import 'character_detail_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharacterCubit>()..loadAllCharacters(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.lightAmber,
          appBar: AppBar(
            title: Center(
              child: Text('Characters',
                  style: TextStyles.harryPotter(
                      height: 24, color: AppColors.goldenAmber)),
            ),
            backgroundColor: AppColors.black,
            elevation: 0,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  final cubit = context.read<CharacterCubit>();
                  switch (value) {
                    case 'all':
                      cubit.loadAllCharacters();
                      break;
                    case 'students':
                      cubit.loadStudents();
                      break;
                    case 'staff':
                      cubit.loadStaff();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'all',
                    child: Row(
                      children: [
                        Icon(Icons.people, color: AppColors.goldenAmber),
                        SizedBox(width: 8),
                        Text('All Characters'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'students',
                    child: Row(
                      children: [
                        Icon(Icons.school, color: AppColors.goldenAmber),
                        SizedBox(width: 8),
                        Text('Students'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'staff',
                    child: Row(
                      children: [
                        Icon(Icons.work, color: AppColors.goldenAmber),
                        SizedBox(width: 8),
                        Text('Staff'),
                      ],
                    ),
                  ),
                ],
                child: const Icon(Icons.filter_list),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
              if (state is CharacterLoading) {
                return MainLoading.mainLoading;
              } else if (state is CharacterLoaded) {
                if (state.characters.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No characters found'),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return GestureDetector(
                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(character: character),
                        ),
                      );
                      },
                      child: _CharacterCard(character: character),
                    );
                  },
                );
              } else if (state is CharacterError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.message}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CharacterCubit>().loadAllCharacters();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Welcome to Characters'));
            },
          ),
        ),
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final Character character;

  const _CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailPage(character: character),
          ),
        );
      },
      child: Card(
        color: AppColors.deepBlack,
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: character.image.isNotEmpty
                  ? NetworkImage(character.image)
                  : null,
              backgroundColor: Colors.amber[100],
              child: character.image.isEmpty
                  ? const Icon(Icons.person, size: 30, color: Colors.amber)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name.isNotEmpty ? character.name : 'Unknown',
                    style: TextStyles.harryPotter(
                        fontSize: 18, color: AppColors.goldenAmber),
                  ),
                  const SizedBox(height: 4),
                  if (character.house.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 16,
                          color: _getHouseColor(character.house),
                        ),
                        const SizedBox(width: 4),
                        Text(character.house,
                            style: TextStyles.harryPotter(
                                fontSize: 12,
                                color: _getHouseColor(character.house))),
                      ],
                    ),
                  if (character.actor.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.movie, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text('Played by ${character.actor}',
                              style: TextStyles.harryPotter(
                                  fontSize: 14,
                                  color: AppColors.harryPotterBrown)),
                        ),
                      ],
                    ),
                  ],
                  if (character.species.isNotEmpty &&
                      character.species != 'human') ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.pets, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          character.species,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Column(
              children: [
                if (character.hogwartsStudent)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Student',
                      style: TextStyles.harryPotter(
                          fontSize: 12, color: Colors.blue),
                    ),
                  ),
                if (character.hogwartsStaff)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Staff',
                      style: TextStyles.harryPotter(
                          fontSize: 12, color: Colors.green),
                    ),
                  ),
                if (!character.alive)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Deceased',
                      style: TextStyles.harryPotter(
                          fontSize: 12, color: Colors.red),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Color _getHouseColor(String house) {
    switch (house.toLowerCase()) {
      case 'gryffindor':
        return Colors.red;
      case 'slytherin':
        return Colors.green;
      case 'ravenclaw':
        return Colors.blue;
      case 'hufflepuff':
        return Colors.yellow[800]!;
      default:
        return Colors.grey;
    }
  }
}
