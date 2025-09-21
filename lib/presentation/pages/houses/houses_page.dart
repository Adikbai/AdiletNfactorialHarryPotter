import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_adilet/core/theme/app_colors.dart';
import 'package:harry_potter_adilet/core/theme/text_styles.dart';
import 'package:harry_potter_adilet/presentation/widgets/main_loading.dart';
import '../../../presentation/cubits/character/character_cubit.dart';
import '../../../presentation/cubits/character/character_state.dart';
import '../../../domain/entities/character.dart';
import '../../../core/di/service_locator.dart';
import '../characters/character_detail_page.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightAmber,
      appBar: AppBar(
        title: Text('Hogwarts Houses',
            style: TextStyles.harryPotter(
                fontSize: 24, color: AppColors.goldenAmber)),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Select a Hogwarts House',
              style: TextStyles.harryPotter(
                  fontSize: 20, color: AppColors.harryPotterGold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _HouseCard(
                    houseName: 'Gryffindor',
                    description: 'Brave, daring, and chivalrous',
                    color: Colors.red,
                    icon: Icons.local_fire_department,
                    onTap: () => _navigateToHouseCharacters(context, 'gryffindor'),
                  ),
                  _HouseCard(
                    houseName: 'Slytherin',
                    description: 'Ambitious, cunning, and resourceful',
                    color: Colors.green,
                    icon: Icons.psychology,
                    onTap: () => _navigateToHouseCharacters(context, 'slytherin'),
                  ),
                  _HouseCard(
                    houseName: 'Ravenclaw',
                    description: 'Wise, witty, and intelligent',
                    color: Colors.blue,
                    icon: Icons.school,
                    onTap: () => _navigateToHouseCharacters(context, 'ravenclaw'),
                  ),
                  _HouseCard(
                    houseName: 'Hufflepuff',
                    description: 'Loyal, patient, and kind',
                    color: Colors.yellow[800]!,
                    icon: Icons.favorite,
                    onTap: () => _navigateToHouseCharacters(context, 'hufflepuff'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToHouseCharacters(BuildContext context, String house) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HouseCharactersPage(house: house),
      ),
    );
  }
}

class _HouseCard extends StatelessWidget {
  final String houseName;
  final String description;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _HouseCard({
    required this.houseName,
    required this.description,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.2),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                houseName,
                style: TextStyles.harryPotter(
                    fontSize: 18, color: color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyles.harryPotter(
                    fontSize: 12, color: AppColors.charcoal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HouseCharactersPage extends StatelessWidget {
  final String house;

  const HouseCharactersPage({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharacterCubit>()..loadCharactersByHouse(house),
      child: Scaffold(
        backgroundColor: AppColors.lightAmber,
        appBar: AppBar(
          title: Text('${house.substring(0, 1).toUpperCase()}${house.substring(1)} House',
              style: TextStyles.harryPotter(
                  fontSize: 20, color: AppColors.goldenAmber)),
          backgroundColor: AppColors.black,
          elevation: 0,
        ),
        body: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return MainLoading.mainLoading;
            } else if (state is CharacterLoaded) {
              if (state.characters.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off, size: 64, color: AppColors.harryPotterGold),
                      const SizedBox(height: 16),
                      Text('No characters found in ${house.substring(0, 1).toUpperCase()}${house.substring(1)}',
                          style: TextStyles.harryPotter(
                              fontSize: 16, color: AppColors.primaryText)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final character = state.characters[index];
                  return _CharacterCard(character: character);
                },
              );
            } else if (state is CharacterError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: TextStyles.harryPotter(
                          fontSize: 16, color: AppColors.primaryText),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CharacterCubit>().loadCharactersByHouse(house);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amber,
                        foregroundColor: AppColors.black,
                      ),
                      child: Text('Retry',
                          style: TextStyles.harryPotter(
                              fontSize: 14, color: AppColors.black)),
                    ),
                  ],
                ),
              );
            }
            return Center(
                child: Text('Loading...',
                    style: TextStyles.harryPotter(
                        fontSize: 18, color: AppColors.primaryText)));
          },
        ),
      ),
    );
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
              backgroundColor: AppColors.amber.withOpacity(0.2),
              child: character.image.isEmpty
                  ? Icon(Icons.person, size: 30, color: AppColors.amber)
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
                  if (character.actor.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('Played by ${character.actor}',
                        style: TextStyles.harryPotter(
                            fontSize: 14, color: AppColors.harryPotterBrown)),
                  ],
                ],
              ),
            ),
            Column(
              children: [
                if (character.hogwartsStudent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Student',
                      style: TextStyles.harryPotter(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                if (character.hogwartsStaff)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Staff',
                      style: TextStyles.harryPotter(fontSize: 12, color: Colors.green),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}