import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/daos/customer_dao.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/customer_action_helper.dart';
import '../../../core/utils/formatters.dart';

final customerDetailsProvider = FutureProvider.autoDispose.family<Customer?, int>((ref, customerId) {
  return ref.watch(customerDaoProvider).getCustomerById(customerId);
});

final customerFinancialSummaryProvider = FutureProvider.autoDispose.family<CustomerFinancialSummary, int>((ref, customerId) {
  return ref.watch(customerDaoProvider).getCustomerFinancialSummary(customerId);
});

final customerJobsProvider = FutureProvider.autoDispose.family<List<RepairJob>, int>((ref, customerId) {
  return ref.watch(repairJobDaoProvider).getAllJobs(customerId: customerId);
});

final customerInvoicesProvider = FutureProvider.autoDispose.family<List<Invoice>, int>((ref, customerId) {
  return ref.watch(invoiceDaoProvider).getAllInvoices(customerId: customerId);
});

final customerPaymentsProvider = FutureProvider.autoDispose.family<List<Payment>, int>((ref, customerId) {
  return ref.watch(paymentDaoProvider).getPayments(customerId: customerId);
});

final customerLedgerProvider = FutureProvider.autoDispose.family<List<CustomerLedgerEntry>, int>((ref, customerId) {
  return ref.watch(customerDaoProvider).getCustomerLedger(customerId);
});

class CustomerDetailsScreen extends ConsumerStatefulWidget {
  final int customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  @override
  ConsumerState<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends ConsumerState<CustomerDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshAll() {
    ref.invalidate(customerDetailsProvider(widget.customerId));
    ref.invalidate(customerFinancialSummaryProvider(widget.customerId));
    ref.invalidate(customerJobsProvider(widget.customerId));
    ref.invalidate(customerInvoicesProvider(widget.customerId));
    ref.invalidate(customerPaymentsProvider(widget.customerId));
    ref.invalidate(customerLedgerProvider(widget.customerId));
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final customerAsync = ref.watch(customerDetailsProvider(widget.customerId));
    final summaryAsync = ref.watch(customerFinancialSummaryProvider(widget.customerId));
    final settingsAsync = ref.watch(businessSettingsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(customerAsync.value?.name ?? 'ग्राहक तपशील'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: strings.edit,
            onPressed: () async {
              await context.push('/customers/${widget.customerId}/edit');
              _refreshAll();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: strings.delete,
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('ग्राहक हटवायचा आहे का?'),
                  content: const Text('हा ग्राहक डिलीट केल्यास तो यादीतून काढला जाईल. जुना हिशोब डेटा सुरक्षित राहील.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(strings.cancel)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => Navigator.pop(ctx, true),
                      child: Text(strings.delete),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                await ref.read(customerDaoProvider).softDeleteCustomer(widget.customerId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: customerAsync.when(
        data: (customer) {
          if (customer == null) {
            return const Center(child: Text('ग्राहक सापडला नाही (Customer not found)'));
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Info Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: AppTheme.primaryBlue,
                                    child: Text(
                                      customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
                                      style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          customer.name,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              'मोबाईल: ${customer.mobile}',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                                            ),
                                            const SizedBox(width: 6),
                                            InkWell(
                                              borderRadius: BorderRadius.circular(12),
                                              onTap: () => CustomerActionHelper.callPhone(context, customer.mobile),
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.withOpacity(0.12),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.phone, size: 16, color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (customer.alternateMobile != null && customer.alternateMobile!.isNotEmpty) ...[
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                'पर्यायी: ${customer.alternateMobile}',
                                                style: const TextStyle(fontSize: 13, color: Colors.black54),
                                              ),
                                              const SizedBox(width: 6),
                                              InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () => CustomerActionHelper.callPhone(context, customer.alternateMobile!),
                                                child: Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green.withOpacity(0.12),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(Icons.phone_outlined, size: 14, color: Colors.green),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  // Notify button
                                  OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.green.shade700,
                                      side: BorderSide(color: Colors.green.shade700),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    ),
                                    icon: const Icon(Icons.send_rounded, size: 16),
                                    label: const Text('मेसेज', style: TextStyle(fontSize: 12)),
                                    onPressed: () {
                                      final summary = summaryAsync.value;
                                      final settings = settingsAsync.value;
                                      CustomerActionHelper.showNotifyOptions(
                                        context,
                                        rawPhone: customer.mobile,
                                        customerName: customer.name,
                                        billedAmount: summary?.totalBilled ?? 0.0,
                                        paidAmount: summary?.totalPaid ?? 0.0,
                                        pendingAmount: summary?.outstandingBalance ?? 0.0,
                                        shopName: settings?.shopName ?? 'प्रताप मोटर',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              if (customer.villageCity != null || customer.address != null) ...[
                                const Divider(height: 20),
                                if (customer.villageCity != null && customer.villageCity!.isNotEmpty)
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text('गाव/शहर: ${customer.villageCity}'),
                                    ],
                                  ),
                                if (customer.address != null && customer.address!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.home, size: 16, color: Colors.grey),
                                        const SizedBox(width: 6),
                                        Expanded(child: Text('पत्ता: ${customer.address}')),
                                      ],
                                    ),
                                  ),
                              ],
                              if (customer.notes != null && customer.notes!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'टीप: ${customer.notes}',
                                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Financial Summary
                      summaryAsync.when(
                        data: (summary) => Row(
                          children: [
                            Expanded(
                              child: _SummaryBox(
                                label: strings.totalBilled,
                                amount: Formatters.currency(summary.totalBilled),
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _SummaryBox(
                                label: strings.totalPaid,
                                amount: Formatters.currency(summary.totalPaid),
                                color: AppTheme.successGreen,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _SummaryBox(
                                label: strings.outstandingBalance,
                                amount: Formatters.currency(summary.outstandingBalance),
                                color: summary.outstandingBalance > 0 ? AppTheme.errorRed : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (_, __) => const SizedBox(),
                      ),
                      const SizedBox(height: 16),

                      // Quick Actions for Customer
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await context.push('/jobs/add?customerId=${customer.id}');
                                _refreshAll();
                              },
                              icon: const Icon(Icons.build, size: 16),
                              label: const Text('नवीन काम'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await context.push('/billing/new?customerId=${customer.id}');
                                _refreshAll();
                              },
                              icon: const Icon(Icons.receipt, size: 16),
                              label: const Text('नवीन बिल'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: AppTheme.primaryBlue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppTheme.primaryBlue,
                    tabs: const [
                      Tab(text: 'कामे (Jobs)'),
                      Tab(text: 'बिल (Bills)'),
                      Tab(text: 'पेमेंट (Payments)'),
                      Tab(text: 'खतावणी (Ledger)'),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _CustomerJobsTab(customerId: customer.id),
                _CustomerBillsTab(customerId: customer.id),
                _CustomerPaymentsTab(customerId: customer.id),
                _CustomerLedgerTab(customerId: customer.id),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const _SummaryBox({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CustomerJobsTab extends ConsumerWidget {
  final int customerId;
  const _CustomerJobsTab({required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(customerJobsProvider(customerId));

    return jobsAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const Center(child: Text('या ग्राहकाचे कोणतेही काम नाही'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: jobs.length,
          itemBuilder: (context, idx) {
            final job = jobs[idx];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.accentOrange.withOpacity(0.15),
                  child: const Icon(Icons.build, color: AppTheme.accentOrange),
                ),
                title: Text('${job.jobNumber} • ${job.motorType} ${job.motorHp}'),
                subtitle: Text('स्थिती: ${Formatters.statusText(job.jobStatus)}\nतारीख: ${Formatters.date(job.receivedDate)}'),
                trailing: Text(
                  Formatters.currency(job.finalAmount),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onTap: () => context.push('/jobs/${job.id}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _CustomerBillsTab extends ConsumerWidget {
  final int customerId;
  const _CustomerBillsTab({required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(customerInvoicesProvider(customerId));

    return billsAsync.when(
      data: (bills) {
        if (bills.isEmpty) {
          return const Center(child: Text('या ग्राहकाचे कोणतेही बिल नाही'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: bills.length,
          itemBuilder: (context, idx) {
            final bill = bills[idx];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.withOpacity(0.15),
                  child: const Icon(Icons.receipt, color: Colors.teal),
                ),
                title: Text(bill.invoiceNumber),
                subtitle: Text('तारीख: ${Formatters.date(bill.invoiceDate)}\nबाकी: ${Formatters.currency(bill.pendingAmount)}'),
                trailing: Text(
                  Formatters.currency(bill.grandTotal),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onTap: () => context.push('/billing/${bill.id}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _CustomerPaymentsTab extends ConsumerWidget {
  final int customerId;
  const _CustomerPaymentsTab({required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(customerPaymentsProvider(customerId));

    return paymentsAsync.when(
      data: (payments) {
        if (payments.isEmpty) {
          return const Center(child: Text('कोणतेही पेमेंट जमा नाही'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: payments.length,
          itemBuilder: (context, idx) {
            final p = payments[idx];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.successGreen.withOpacity(0.15),
                  child: const Icon(Icons.check, color: AppTheme.successGreen),
                ),
                title: Text('जमा: ${Formatters.currency(p.amountReceived)}'),
                subtitle: Text('प्रकार: ${p.paymentMode.toUpperCase()} • ${Formatters.date(p.paymentDate)}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _CustomerLedgerTab extends ConsumerWidget {
  final int customerId;
  const _CustomerLedgerTab({required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgerAsync = ref.watch(customerLedgerProvider(customerId));
    final customer = ref.watch(customerDetailsProvider(customerId)).value;
    final summary = ref.watch(customerFinancialSummaryProvider(customerId)).value;
    final settings = ref.watch(businessSettingsStreamProvider).value;

    return ledgerAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(
            child: Text(
              'कोणतीही खतावणी नोंद उपलब्ध नाही\n(No ledger transactions yet)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // Statement Share Card
            Card(
              color: Colors.green.shade50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.green.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'खाते उतारा (Statement)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.successGreen),
                        ),
                        Text(
                          'बाकी: ${Formatters.currency(summary?.outstandingBalance ?? 0.0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.whatsappGreen,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.chat, size: 18),
                        label: const Text('WhatsApp वर खाते उतारा पाठवा (Share Statement)'),
                        onPressed: customer == null
                            ? null
                            : () {
                                CustomerActionHelper.shareCustomerLedgerWhatsApp(
                                  rawPhone: customer.mobile,
                                  customerName: customer.name,
                                  entries: entries,
                                  totalBilled: summary?.totalBilled ?? 0.0,
                                  totalPaid: summary?.totalPaid ?? 0.0,
                                  outstandingBalance: summary?.outstandingBalance ?? 0.0,
                                  shopName: settings?.shopName ?? 'प्रताप इलेक्ट्रिकल्स & मोटर रिवाइंडिंग',
                                  ownerName: settings?.ownerName ?? 'दिनेश जाधव',
                                  ownerPhone: settings?.mobileNumber ?? '9623314436',
                                );
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Ledger Entries
            ...entries.map((entry) {
              final isDebit = entry.type == 'debit';

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: isDebit ? Colors.red.withOpacity(0.12) : Colors.green.withOpacity(0.12),
                                  child: Icon(
                                    isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                                    size: 16,
                                    color: isDebit ? Colors.red : Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    Text(
                                      Formatters.date(entry.date),
                                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  isDebit ? '+ ${Formatters.currency(entry.debit)}' : '- ${Formatters.currency(entry.credit)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isDebit ? Colors.red.shade700 : Colors.green.shade700,
                                  ),
                                ),
                                Text(
                                  isDebit ? 'नावे (Bill Debit)' : 'जमा (Payment Credit)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isDebit ? Colors.red.shade700 : Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                entry.subtitle,
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'बाकी शिल्लक: ',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  Formatters.currency(entry.runningBalance),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: entry.runningBalance > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
