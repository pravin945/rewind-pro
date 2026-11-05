import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';

final customerSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final customerListProvider = StreamProvider.autoDispose<List<Customer>>((ref) {
  final query = ref.watch(customerSearchQueryProvider);
  return ref.watch(customerDaoProvider).watchAllCustomers(query: query);
});

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final customersAsync = ref.watch(customerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customerList),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: strings.addCustomer,
            onPressed: () => context.push('/customers/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: strings.searchCustomer,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ref.read(customerSearchQueryProvider.notifier).state = '';
                  },
                ),
              ),
              onChanged: (val) {
                ref.read(customerSearchQueryProvider.notifier).state = val;
              },
            ),
          ),

          // List
          Expanded(
            child: customersAsync.when(
              data: (customers) {
                if (customers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'कोणतेही ग्राहक सापडले नाहीत\n(No customers found)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/customers/add'),
                          icon: const Icon(Icons.add),
                          label: Text(strings.addCustomer),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  itemCount: customers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return _CustomerCard(customer: customer);
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
        onPressed: () => context.push('/customers/add'),
        tooltip: strings.addCustomer,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CustomerCard extends ConsumerWidget {
  final Customer customer;

  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerDao = ref.watch(customerDaoProvider);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/customers/${customer.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: FutureBuilder(
            future: customerDao.getCustomerFinancialSummary(customer.id),
            builder: (context, snapshot) {
              final summary = snapshot.data;
              final balance = summary?.outstandingBalance ?? 0.0;

              return Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.primaryBlue.withOpacity(0.12),
                    child: Text(
                      customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              customer.mobile,
                              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                            ),
                            if (customer.villageCity != null && customer.villageCity!.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.location_on, size: 14, color: Colors.grey),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  customer.villageCity!,
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Formatters.currency(balance),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: balance > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                        ),
                      ),
                      Text(
                        balance > 0 ? 'बाकी (Due)' : 'निरंक (Clear)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: balance > 0 ? AppTheme.errorRed : AppTheme.successGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

