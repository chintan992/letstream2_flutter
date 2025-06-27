import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  final String overview;
  final String? status;
  final String? budget;
  final String? revenue;
  final List<String>? productionCompanies;

  const AboutTab({
    super.key,
    required this.overview,
    this.status,
    this.budget,
    this.revenue,
    this.productionCompanies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overview,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _buildInfoGrid(),
          const SizedBox(height: 24),
          if (productionCompanies != null && productionCompanies!.isNotEmpty)
            _buildProductionCompanies(),
        ],
      ),
    );
  }

  Widget _buildInfoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        if (status != null) _InfoCard(title: 'Status', value: status!),
        if (budget != null) _InfoCard(title: 'Budget', value: budget!),
        if (revenue != null) _InfoCard(title: 'Revenue', value: revenue!),
      ],
    );
  }

  Widget _buildProductionCompanies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Production Companies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: productionCompanies!
              .map((company) => Chip(label: Text(company)))
              .toList(),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
