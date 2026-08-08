import 'package:demo_project/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: _HeaderImage(
                url: movie.backdropUrl ?? movie.posterUrl,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _InfoChip(
                        icon: Icons.star,
                        label: movie.voteAverage.toStringAsFixed(1),
                      ),
                      _InfoChip(
                        icon: Icons.language,
                        label: movie.language.toUpperCase(),
                      ),
                      if (movie.releaseDate.isNotEmpty)
                        _InfoChip(
                          icon: Icons.calendar_today,
                          label: movie.releaseDate,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Overview', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview.isEmpty
                        ? 'No overview available.'
                        : movie.overview,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text('Details', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _DetailRow(label: 'Popularity', value: movie.popularity.toStringAsFixed(2)),
                  _DetailRow(label: 'Vote count', value: '${movie.voteCount}'),
                  if (movie.casts.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text('Cast', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ...movie.casts.map(
                      (cast) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: cast.profileUrl != null
                              ? NetworkImage(cast.profileUrl!)
                              : null,
                          child: cast.profileUrl == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(cast.name),
                        subtitle: Text(cast.character),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: Icon(Icons.movie_outlined, size: 64)),
      );
    }

    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (context, _, _) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: Icon(Icons.broken_image_outlined, size: 64)),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
