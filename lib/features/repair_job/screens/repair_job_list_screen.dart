import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final jobStatusFilterProvider = StateProvider.autoDispose<String?>((ref) => null);

final jobsListProvider = StreamProvider.autoDispose<List<RepairJob>>((ref) {
  final status = ref.watch(jobStatusFilterProvider);
  return ref.watch(repairJobDaoProvider).watchAllJobs(status: status);
});

class RepairJobListScreen extends ConsumerWidget {
  const RepairJobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final jobsAsync = ref.watch(jobsListProvider);
    final currentStatus = ref.watch(jobStatusFilterProvider);

    final statusOptions = [
      {'key': null, 'label': 'सर्व (All)'},
      {'key': 'received', 'label': strings.statusReceived},
      {'key': 'inspection', 'label': strings.statusInspection},
      {'key': 'inProgress', 'label': strings.statusInProgress},
      {'key': 'waitingForParts', 'label': strings.statusWaitingParts},
      {'key': 'completed', 'label': strings.statusCompleted},
      {'key': 'delivered', 'label': strings.statusDelivered},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.navJobs),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: strings.newRepairJob,
            onPressed: () => context.push('/jobs/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: statusOptions.map((opt) {
                final isSelected = currentStatus == opt['key'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(opt['label']!),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryBlue.withOpacity(0.18),
                    checkmarkColor: AppTheme.primaryBlue,
                    onSelected: (_) {
                      ref.read(jobStatusFilterProvider.notifier).state = opt['key'] as String?;
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Job list
          Expanded(
            child: jobsAsync.when(
              data: (jobs) {
                if (jobs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.build_circle_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'कोणतीही रिपेअरिंग कामे सापडली नाहीत\n(No repair jobs found)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/jobs/add'),
                          icon: const Icon(Icons.add),
                          label: Text(strings.newRepairJob),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: jobs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final job = jobs[idx];
                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => context.push('/jobs/${job.id}'),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    job.jobNumber,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryBlue),
                                  ),
                                  _StatusBadge(status: job.jobStatus),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${job.motorType} • ${job.motorBrand} ${job.motorHp} (${job.motorPhase})',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'फॉल्ट: ${job.problemDescription}',
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Divider(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'तारीख: ${Formatters.date(job.receivedDate)}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    'रक्कम: ${Formatters.currency(job.finalAmount)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/jobs/add'),
        tooltip: strings.newRepairJob,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case 'received':
        bg = Colors.blue.shade50;
        fg = Colors.blue.shade800;
        break;
      case 'inspection':
        bg = Colors.amber.shade50;
        fg = Colors.amber.shade800;
        break;
      case 'inProgress':
        bg = Colors.orange.shade50;
        fg = Colors.orange.shade800;
        break;
      case 'waitingForParts':
        bg = Colors.purple.shade50;
        fg = Colors.purple.shade800;
        break;
      case 'completed':
        bg = Colors.green.shade50;
        fg = Colors.green.shade800;
        break;
      case 'delivered':
        bg = Colors.grey.shade100;
        fg = Colors.grey.shade800;
        break;
      default:
        bg = Colors.grey.shade100;
        fg = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Text(
        Formatters.statusText(status),
        style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

