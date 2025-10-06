import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../navigations/app_routes.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/widgets/note_card.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final noteType = arguments?['noteType'] as NoteType?;

    if (noteType == null) {
      return _buildAllNotesLibrary(context);
    }

    return _buildTypedLibrary(context, noteType);
  }

  Widget _buildAllNotesLibrary(BuildContext context) {
    useListenable(HiveService.notesListenable());
    final allNotes = HiveService.getAllNotes();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.secondaryBeigeDark,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Library',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.primaryBrown,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryBrown),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            labelColor: AppColors.primaryBrown,
            unselectedLabelColor: AppColors.neutralMediumGray,
            indicatorColor: AppColors.primaryBrown,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Favorite'),
              Tab(text: 'Disliked'),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryBeigeLight,
                  AppColors.neutralWhite,
                  AppColors.accentSuccessLight,
                ],
                stops: [0.0, 0.2, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TabBarView(
              children: [
                _buildNotesList(context, allNotes),
                _buildNotesList(context, HiveService.getCompletedNotes()),
                _buildNotesList(context, HiveService.getFavoriteNotes()),
                _buildNotesList(context, HiveService.getDislikedNotes()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypedLibrary(BuildContext context, NoteType noteType) {
    useListenable(HiveService.notesListenable());
    final notes = HiveService.getNotesByType(noteType);

    String getLibraryTitle(NoteType type) {
      switch (type) {
        case NoteType.quickNotes:
          return 'Quick Notes';
        case NoteType.successes:
          return 'Successes';
        case NoteType.goals:
          return 'Goals';
        case NoteType.journal:
          return 'Journal';
        case NoteType.habits:
          return 'Habits';
        case NoteType.inspiration:
          return 'Inspiration';
      }
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          getLibraryTitle(noteType),
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.primaryBrown,
            fontWeight: AppTypography.semiBold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBrown),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryBeigeLight,
                AppColors.neutralWhite,
                AppColors.accentSuccessLight,
              ],
              stops: [0.0, 0.2, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _buildNotesList(context, notes),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 64, color: AppColors.neutralMediumGray),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primaryBrown,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first note to get started',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.neutralMediumGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList(BuildContext context, List<Note> notes) {
    if (notes.isEmpty) return _buildEmptyState();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(
          note: note,
          showCategoryIcon: true,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.noteDetail,
            arguments: {'noteId': note.id},
          ),
        );
      },
    );
  }

  // Removed obsolete helpers; unified NoteCard handles visuals
}
