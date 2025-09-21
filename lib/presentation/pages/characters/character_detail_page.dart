import 'package:flutter/material.dart';
import 'package:harry_potter_adilet/core/theme/app_colors.dart';
import 'package:harry_potter_adilet/core/theme/text_styles.dart';
import 'package:harry_potter_adilet/core/services/tts_service.dart';
import 'package:harry_potter_adilet/core/di/service_locator.dart';
import '../../../domain/entities/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightAmber,
      appBar: AppBar(
        title: Text(
          character.name.isNotEmpty ? character.name : 'Character Details',
          style: TextStyles.harryPotter(
              fontSize: 20, color: AppColors.goldenAmber),
        ),
        backgroundColor: AppColors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final ttsService = getIt<TTSService>();
              await ttsService.speak(_buildCharacterDescription());
            },
            icon: const Icon(
              Icons.volume_up,
              color: AppColors.goldenAmber,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            const SizedBox(height: 20),
            _buildBasicInfoSection(),
            const SizedBox(height: 20),
            _buildPhysicalTraitsSection(),
            const SizedBox(height: 20),
            _buildMagicalInfoSection(),
            const SizedBox(height: 20),
            _buildActorSection(),
            const SizedBox(height: 20),
            _buildStatusSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.deepBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.amber.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: character.image.isNotEmpty
            ? Image.network(
                character.image,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
              )
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.magicalRadialGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 80,
              color: AppColors.amber,
            ),
            const SizedBox(height: 16),
            Text(
              character.name.isNotEmpty ? character.name : 'Unknown Character',
              style: TextStyles.harryPotter(
                  fontSize: 18, color: AppColors.goldenAmber),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: 'Basic Information',
      child: Column(
        children: [
          _buildDetailRow('Name', character.name.isNotEmpty ? character.name : 'Unknown'),
          if (character.alternateNames.isNotEmpty)
            _buildDetailRow('Alternate Names', character.alternateNames.join(', ')),
          if (character.house.isNotEmpty)
            _buildDetailRow('House', character.house, color: _getHouseColor(character.house)),
          _buildDetailRow('Species', character.species.isNotEmpty ? character.species : 'Unknown'),
          _buildDetailRow('Gender', character.gender.isNotEmpty ? character.gender : 'Unknown'),
          if (character.dateOfBirth != null && character.dateOfBirth!.isNotEmpty)
            _buildDetailRow('Date of Birth', character.dateOfBirth!),
          if (character.yearOfBirth != null)
            _buildDetailRow('Year of Birth', character.yearOfBirth.toString()),
          _buildDetailRow('Ancestry', character.ancestry.isNotEmpty ? character.ancestry : 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildPhysicalTraitsSection() {
    return _buildSection(
      title: 'Physical Traits',
      child: Column(
        children: [
          _buildDetailRow('Eye Color', character.eyeColour.isNotEmpty ? character.eyeColour : 'Unknown'),
          _buildDetailRow('Hair Color', character.hairColour.isNotEmpty ? character.hairColour : 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildMagicalInfoSection() {
    return _buildSection(
      title: 'Magical Information',
      child: Column(
        children: [
          _buildDetailRow('Wizard', character.wizard ? 'Yes' : 'No'),
          if (character.patronus.isNotEmpty)
            _buildDetailRow('Patronus', character.patronus),
          if (character.wand != null && character.wand!.isNotEmpty)
            _buildWandInfo(),
        ],
      ),
    );
  }

  Widget _buildWandInfo() {
    final wand = character.wand!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_fix_high, color: AppColors.amber, size: 16),
              const SizedBox(width: 8),
              Text('Wand Details', 
                  style: TextStyles.harryPotter(fontSize: 14, color: AppColors.goldenAmber)),
            ],
          ),
          const SizedBox(height: 8),
          if (wand['wood'] != null && wand['wood'].toString().isNotEmpty)
            Text('Wood: ${wand['wood']}',
                style: TextStyles.harryPotter(fontSize: 12, color: AppColors.primaryText)),
          if (wand['core'] != null && wand['core'].toString().isNotEmpty)
            Text('Core: ${wand['core']}',
                style: TextStyles.harryPotter(fontSize: 12, color: AppColors.primaryText)),
          if (wand['length'] != null && wand['length'].toString().isNotEmpty)
            Text('Length: ${wand['length']}',
                style: TextStyles.harryPotter(fontSize: 12, color: AppColors.primaryText)),
        ],
      ),
    );
  }

  Widget _buildActorSection() {
    if (character.actor.isEmpty) return const SizedBox();
    
    return _buildSection(
      title: 'Movie Information',
      child: Column(
        children: [
          _buildDetailRow('Portrayed by', character.actor),
          if (character.alternateActors.isNotEmpty)
            _buildDetailRow('Alternate Actors', character.alternateActors.join(', ')),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return _buildSection(
      title: 'Status',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (character.hogwartsStudent)
            _buildStatusChip('Student', Colors.blue),
          if (character.hogwartsStaff)
            _buildStatusChip('Staff', Colors.green),
          _buildStatusChip(character.alive ? 'Alive' : 'Deceased', 
              character.alive ? Colors.green : Colors.red),
          _buildStatusChip(character.wizard ? 'Wizard' : 'Muggle', 
              character.wizard ? AppColors.amber : Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.deepBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getSectionIcon(title),
                color: AppColors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyles.harryPotter(
                    fontSize: 16, color: AppColors.goldenAmber),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyles.harryPotter(
                  fontSize: 12, color: AppColors.secondaryText),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.harryPotter(
                  fontSize: 12, 
                  color: color ?? AppColors.primaryText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyles.harryPotter(fontSize: 12, color: color),
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

  IconData _getSectionIcon(String title) {
    switch (title.toLowerCase()) {
      case 'basic information':
        return Icons.info;
      case 'physical traits':
        return Icons.face;
      case 'magical information':
        return Icons.auto_fix_high;
      case 'movie information':
        return Icons.movie;
      case 'status':
        return Icons.verified;
      default:
        return Icons.info;
    }
  }

  String _buildCharacterDescription() {
    List<String> descriptions = [];
    
    if (character.name.isNotEmpty) {
      descriptions.add('Character name: ${character.name}');
    }
    
    if (character.house.isNotEmpty) {
      descriptions.add('House: ${character.house}');
    }
    
    if (character.species.isNotEmpty && character.species != 'human') {
      descriptions.add('Species: ${character.species}');
    }
    
    if (character.actor.isNotEmpty) {
      descriptions.add('Portrayed by: ${character.actor}');
    }
    
    if (character.hogwartsStudent) {
      descriptions.add('Hogwarts student');
    }
    
    if (character.hogwartsStaff) {
      descriptions.add('Hogwarts staff member');
    }
    
    descriptions.add(character.alive ? 'Status: Alive' : 'Status: Deceased');
    
    return descriptions.join('. ');
  }
}