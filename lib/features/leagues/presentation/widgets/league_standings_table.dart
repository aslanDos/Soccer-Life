import 'package:flutter/material.dart';
import 'package:soccer_life/features/leagues/domain/entity/standing_entity.dart';

// Column widths — defined once, shared by header and rows to guarantee alignment.
const double _kRankW = 20;
const double _kLogoW = 20;
const double _kStatW = 20;
const double _kGoalW = 50;
const double _kPtsW = 35;
const double _kLogoGap = 8;
const double _kTeamGap = 12;
const double _kStatGap = 4;

/// Self-contained standings table. Pass [shrinkWrap] true when embedding inside
/// a parent scroll view (e.g. Overview tab).
class LeagueStandingsTable extends StatelessWidget {
  final List<StandingEntity> standings;
  final bool shrinkWrap;

  const LeagueStandingsTable({
    super.key,
    required this.standings,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final table = Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.secondary),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
          children: [
            const _StandingsHeader(),
            if (shrinkWrap)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: standings.length,
                separatorBuilder: (_, _) => const _DashedDivider(),
                itemBuilder: (_, index) =>
                    _StandingRow(standing: standings[index]),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: standings.length,
                  separatorBuilder: (_, _) => const _DashedDivider(),
                  itemBuilder: (_, index) =>
                      _StandingRow(standing: standings[index]),
                ),
              ),
          ],
        ),
      ),
    );

    if (shrinkWrap) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [table, _ZoneLegend(standings: standings)],
      );
    }

    return Column(
      children: [
        Expanded(child: table),
        _ZoneLegend(standings: standings),
      ],
    );
  }
}

class _StandingsHeader extends StatelessWidget {
  const _StandingsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.secondary)),
      ),
      child: Row(
        children: [
          _StatCell(label: '#', width: _kRankW),
          const SizedBox(width: _kLogoGap),
          Expanded(
            child: Text(
              'Team',
              textAlign: TextAlign.start,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _kTeamGap),
          _StatCell(label: 'M', width: _kStatW),
          const SizedBox(width: _kStatGap),
          _StatCell(label: 'G', width: _kGoalW),
          const SizedBox(width: _kStatGap),
          _StatCell(label: 'PTS', width: _kPtsW, bold: true),
        ],
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final StandingEntity standing;

  const _StandingRow({required this.standing});

  Color _zoneColor() {
    final desc = standing.description?.toLowerCase() ?? '';
    if (desc.contains('champions league')) return Colors.blue;
    if (desc.contains('europa league')) return Colors.orange;
    if (desc.contains('conference')) return Colors.green;
    if (desc.contains('relegation')) return Colors.red;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final goalStr = '${standing.goalsFor}:${standing.goalsAgainst}';

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: _zoneColor(), width: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            _StatCell(label: '${standing.rank}', width: _kRankW),
            const SizedBox(width: _kLogoGap),
            SizedBox(
              width: _kLogoW,
              height: _kLogoW,
              child: standing.teamLogo.isNotEmpty
                  ? Image.network(
                      standing.teamLogo,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: _kLogoGap),
            Expanded(
              child: Text(
                standing.teamName,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: _kTeamGap),
            _StatCell(label: '${standing.played}', width: _kStatW),
            const SizedBox(width: _kStatGap),
            _StatCell(label: goalStr, width: _kGoalW),
            const SizedBox(width: _kStatGap),
            _StatCell(label: '${standing.points}', width: _kPtsW, bold: true),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final double width;
  final bool bold;

  const _StatCell({required this.label, required this.width, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: bold
            ? theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)
            : theme.textTheme.bodySmall,
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: CustomPaint(
        painter: _DashedPainter(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final Color color;

  const _DashedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dash = 4.0;
    const gap = 4.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dash, 0), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) => old.color != color;
}

class _ZoneLegend extends StatelessWidget {
  final List<StandingEntity> standings;

  const _ZoneLegend({required this.standings});

  static const _zones = [
    (keyword: 'champions league', label: 'Champions League', color: Colors.blue),
    (keyword: 'europa league', label: 'Europa League', color: Colors.orange),
    (keyword: 'conference', label: 'Conference League', color: Colors.green),
    (keyword: 'relegation', label: 'Relegation', color: Colors.red),
  ];

  bool _hasZone(String keyword) =>
      standings.any((s) => s.description?.toLowerCase().contains(keyword) == true);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeZones = _zones.where((z) => _hasZone(z.keyword)).toList();

    if (activeZones.isEmpty) return const SizedBox(height: 12);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: activeZones
            .map(
              (z) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: z.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(z.label, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
