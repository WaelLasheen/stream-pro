import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_suggestions_cubit/search_suggestions_cubit.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_suggestions_cubit/search_suggestions_state.dart';
import 'package:stream_pro/feature/search/presentation/widgets/search_suggestion_tile.dart';
import 'package:stream_pro/feature/search/presentation/widgets/search_suggestions_shimmer.dart';
import 'package:stream_pro/generated/l10n.dart';

class SearchSuggestionsView extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;
  final VoidCallback onRetry;

  const SearchSuggestionsView({
    super.key,
    required this.onSuggestionTap,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSuggestionsCubit, SearchSuggestionsState>(
      builder: (context, state) {
        return switch (state) {
          SearchSuggestionsInitial() ||
          SearchSuggestionsLoading() => const SearchSuggestionsShimmer(),
          SearchSuggestionsError() => AppErrorWidget(
            message: state.message,
            onRetry: onRetry,
          ),
          SearchSuggestionsLoaded() when state.suggestions.isEmpty =>
            AppEmptyWidget(
              message: S.current.noSuggestionsFor(state.query),
              icon: Icons.search_off_rounded,
            ),
          SearchSuggestionsLoaded() => ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: state.suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = state.suggestions[index];
              return SearchSuggestionTile(
                suggestion: suggestion,
                onTap: () => onSuggestionTap(suggestion.id),
              );
            },
          ),
        };
      },
    );
  }
}
