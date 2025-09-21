import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';

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
    final allNotes = HiveService.getAllNotes()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'All Notes',
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
          child: allNotes.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: allNotes.length,
                  itemBuilder: (context, index) {
                    final note = allNotes[index];
                    return _buildNoteCard(context, note);
                  },
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
          child: notes.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return _buildNoteCard(context, note);
                  },
                ),
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

  Widget _buildNoteCard(BuildContext context, Note note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: _getNoteTypeColor(note.type), width: 4),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.primaryBrownLight,
                    fontWeight: AppTypography.semiBold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(
                    note.priority,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  note.priority.name.toUpperCase(),
                  style: AppTypography.labelSmall.copyWith(
                    color: _getPriorityColor(note.priority),
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutralDarkGray,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getFormattedDate(note.createdAt),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.neutralMediumGray,
                ),
              ),
              if (note.progressPercent != null)
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.neutralLightGray,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 60 * (note.progressPercent! / 100),
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.accentSuccess,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${note.progressPercent}%',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.accentSuccess,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getNoteTypeColor(NoteType type) {
    switch (type) {
      case NoteType.quickNotes:
        return AppColors.accentInfo;
      case NoteType.successes:
        return AppColors.accentSuccess;
      case NoteType.goals:
        return AppColors.accentWarning;
      case NoteType.journal:
        return AppColors.accentError;
      case NoteType.habits:
        return AppColors.leafGreen;
      case NoteType.inspiration:
        return AppColors.accentError;
    }
  }

  Color _getPriorityColor(PriorityLevel priority) {
    switch (priority) {
      case PriorityLevel.high:
        return AppColors.accentError;
      case PriorityLevel.medium:
        return AppColors.accentWarning;
      case PriorityLevel.low:
        return AppColors.accentSuccess;
    }
  }

  String _getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
