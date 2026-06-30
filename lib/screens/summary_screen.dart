import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SubjectProvider>(
        builder: (context, subjectProvider, child) {
          final totalSubjects = subjectProvider.totalSubjects;
          final averageMark = subjectProvider.averageMark;
          final overallGrade = subjectProvider.overallGrade;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Header
              Text(
              'Your Performance',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
                Text(
                  'Academic insights at a glance',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                if (totalSubjects == 0)
            Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.assignment_outlined,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
          'No subjects yet',
          style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
          'Add subjects to track your performance',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
          ),
          ],
          ),
          )
          else ...[
          // Overall Grade Card
          Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
          BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
          ),
          ],
          ),
          child: Column(
          children: [
          Text(
          'Overall Grade',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
          fontSize: 13,
          letterSpacing: 1,
          ),
          ),
          const SizedBox(height: 16),
          Text(
          overallGrade,
          style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          ),
          ),
          const SizedBox(height: 12),
          Container(
          padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
          ),
          decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
          'Average: ${averageMark.toStringAsFixed(2)}/100',
          style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          ),
          ),
          ),
          ],
          ),
          ),
          const SizedBox(height: 32),

          // Statistics
          Text(
          'Statistics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 16),

          _StatCard(
          icon: Icons.book,
          label: 'Total Subjects',
          value: '$totalSubjects',
          color: Colors.purple,
          ),
          const SizedBox(height: 12),

          _StatCard(
          icon: Icons.trending_up,
          label: 'Average Marks',
          value: averageMark.toStringAsFixed(2),
          color: Colors.teal,
          ),
          const SizedBox(height: 32),

          // Grade Distribution
          Text(
          'Grade Distribution',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 16),

          _GradeDistributionItem(
          grade: 'A',
          count: subjectProvider.getSubjectsCountByGrade('A'),
          color: Colors.green,
          ),
          const SizedBox(height: 10),

          _GradeDistributionItem(
          grade: 'B',
          count: subjectProvider.getSubjectsCountByGrade('B'),
          color: Colors.blue,
          ),
          const SizedBox(height: 10),

          _GradeDistributionItem(
          grade: 'C',
          count: subjectProvider.getSubjectsCountByGrade('C'),
          color: Colors.orange,
          ),
          const SizedBox(height: 10),

          _GradeDistributionItem(
          grade: 'F',
          count: subjectProvider.getSubjectsCountByGrade('F'),
          color: Colors.red,
          ),
          ],
          ],
          ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradeDistributionItem extends StatelessWidget {
  final String grade;
  final int count;
  final Color color;

  const _GradeDistributionItem({
    required this.grade,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
        Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            grade,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade $grade',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$count ${count == 1 ? 'subject' : 'subjects'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${(count / count).isNaN ? 0 : count}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ],
      ),
    );
  }
}