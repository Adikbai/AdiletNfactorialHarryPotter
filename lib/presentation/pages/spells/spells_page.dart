import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_adilet/core/theme/app_colors.dart';
import 'package:harry_potter_adilet/core/theme/text_styles.dart';
import 'package:harry_potter_adilet/presentation/widgets/main_loading.dart';
import '../../../presentation/cubits/spell/spell_cubit.dart';
import '../../../presentation/cubits/spell/spell_state.dart';
import '../../../domain/entities/spell.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/tts_service.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpellCubit>()..loadAllSpells(),
      child: Scaffold(
        backgroundColor: AppColors.lightAmber,
        appBar: AppBar(
          title: Text('Spells',
              style: TextStyles.harryPotter(
                  fontSize: 24, color: AppColors.goldenAmber)),
          backgroundColor: AppColors.black,
          elevation: 0,
        ),
        body: BlocBuilder<SpellCubit, SpellState>(
          builder: (context, state) {
            if (state is SpellLoading) {
              return MainLoading.mainLoading;
            } else if (state is SpellLoaded) {
              if (state.spells.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.auto_fix_off,
                          size: 64, color: AppColors.harryPotterGold),
                      const SizedBox(height: 16),
                      Text('No spells found',
                          style: TextStyles.harryPotter(
                              fontSize: 16, color: AppColors.primaryText)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.spells.length,
                itemBuilder: (context, index) {
                  final spell = state.spells[index];
                  return _SpellCard(spell: spell);
                },
              );
            } else if (state is SpellError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: AppColors.error),
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
                        context.read<SpellCubit>().loadAllSpells();
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
                child: Text('Welcome to Spells',
                    style: TextStyles.harryPotter(
                        fontSize: 18, color: AppColors.primaryText)));
          },
        ),
      ),
    );
  }
}

class _SpellCard extends StatelessWidget {
  final Spell spell;

  const _SpellCard({required this.spell});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.deepBlack,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.auto_fix_high,
                    color: AppColors.amber,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    spell.name.isNotEmpty ? spell.name : 'Unknown Spell',
                    style: TextStyles.harryPotter(
                        fontSize: 18, color: AppColors.goldenAmber),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final ttsService = getIt<TTSService>();
                    final textToSpeak =
                        spell.name.isNotEmpty ? spell.name : 'Unknown Spell';
                    await ttsService.speak(textToSpeak);
                  },
                  icon: const Icon(
                    Icons.volume_up,
                    color: AppColors.amber,
                    size: 20,
                  ),
                ),
              ],
            ),
            if (spell.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.charcoal,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.amber.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.amber,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        spell.description,
                        style: TextStyles.harryPotter(
                            fontSize: 14, color: AppColors.primaryText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
