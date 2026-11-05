import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/navigation/main_scaffold.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/customer/screens/customer_list_screen.dart';
import '../../features/customer/screens/customer_details_screen.dart';
import '../../features/customer/screens/add_edit_customer_screen.dart';
import '../../features/repair_job/screens/repair_job_list_screen.dart';
import '../../features/repair_job/screens/repair_job_details_screen.dart';
import '../../features/repair_job/screens/add_repair_job_screen.dart';
import '../../features/billing/screens/billing_list_screen.dart';
import '../../features/billing/screens/create_bill_screen.dart';
import '../../features/billing/screens/invoice_details_screen.dart';
import '../../features/inventory/screens/inventory_screen.dart';
import '../../features/inventory/screens/add_product_screen.dart';
import '../../features/daily_work/screens/daily_work_screen.dart';
import '../../features/payment/screens/pending_payments_screen.dart';
import '../../features/reports/screens/reports_screen.dart';
import '../../features/expenses/screens/expenses_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/backup/screens/backup_screen.dart';
import '../../features/more/screens/more_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Home (Dashboard)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),

        // Tab 2: Customers
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/customers',
              builder: (context, state) => const CustomerListScreen(),
            ),
          ],
        ),

        // Tab 3: Repair Jobs
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/jobs',
              builder: (context, state) => const RepairJobListScreen(),
            ),
          ],
        ),

        // Tab 4: Billing
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/billing',
              builder: (context, state) => const BillingListScreen(),
            ),
          ],
        ),

        // Tab 5: More
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              builder: (context, state) => const MoreScreen(),
            ),
          ],
        ),
      ],
    ),

    // Push routes (outside bottom bar tabs)
    // Customer routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/add',
      builder: (context, state) => const AddEditCustomerScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return CustomerDetailsScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id/edit',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return AddEditCustomerScreen(customerId: id);
      },
    ),

    // Job routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/jobs/add',
      builder: (context, state) {
        final custIdStr = state.uri.queryParameters['customerId'];
        final custId = custIdStr != null ? int.tryParse(custIdStr) : null;
        return AddRepairJobScreen(preselectedCustomerId: custId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/jobs/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return RepairJobDetailsScreen(jobId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/jobs/:id/edit',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return AddRepairJobScreen(jobId: id);
      },
    ),

    // Billing routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/billing/new',
      builder: (context, state) {
        final cat = state.uri.queryParameters['category'];
        final custIdStr = state.uri.queryParameters['customerId'];
        final custId = custIdStr != null ? int.tryParse(custIdStr) : null;
        final jobIdStr = state.uri.queryParameters['repairJobId'];
        final jobId = jobIdStr != null ? int.tryParse(jobIdStr) : null;

        return CreateBillScreen(
          initialCategory: cat,
          preselectedCustomerId: custId,
          repairJobId: jobId,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/billing/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return InvoiceDetailsScreen(invoiceId: id);
      },
    ),

    // Inventory routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/inventory',
      builder: (context, state) {
        final lowStockStr = state.uri.queryParameters['lowStock'];
        final lowStock = lowStockStr == 'true';
        return InventoryScreen(initialLowStock: lowStock);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/inventory/add',
      builder: (context, state) => const AddProductScreen(),
    ),

    // Daily Work
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/daily-work',
      builder: (context, state) => const DailyWorkScreen(),
    ),

    // Pending Payments
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/pending-payments',
      builder: (context, state) => const PendingPaymentsScreen(),
    ),

    // Reports
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/reports',
      builder: (context, state) => const ReportsScreen(),
    ),

    // Expenses
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/expenses',
      builder: (context, state) => const ExpensesScreen(),
    ),

    // Settings
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    // Backup
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/more/backup',
      builder: (context, state) => const BackupScreen(),
    ),
  ],
);

