import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/presentation/upcoming_sips_presenter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class UpcomingSipsPage extends StatefulWidget {
  const UpcomingSipsPage({super.key});

  @override
  State<UpcomingSipsPage> createState() => _UpcomingSipsPage();
}

class _UpcomingSipsPage
    extends PageState<UpcomingSipsViewState, UpcomingSipsPage, UpcomingSipsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchUpcomingSips();
  }

  @override
  Widget buildWidget(final BuildContext context, final UpcomingSipsViewState snapshot) {
    List<UpcomingSipPaymentVO> upcomingSips = snapshot.upcomingSipPayments;
    DateTime now = DateTime.now();
    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime nextYear = DateTime(now.year + 1, 1, 1);

    double currentMonthTotal = 0;
    double nextMonthTotal = 0;
    double currentYearTotal = 0;
    double nextYearTotal = 0;

    List<UpcomingSipPaymentVO> currentMonthSips = [];
    List<UpcomingSipPaymentVO> nextMonthSips = [];
    List<UpcomingSipPaymentVO> currentYearSips = [];
    List<UpcomingSipPaymentVO> nextYearSips = [];

    for (var sip in upcomingSips) {
      if (sip.paymentDate.year == now.year) {
        currentYearTotal += sip.amount;
        currentYearSips.add(sip);
        if (sip.paymentDate.month == now.month) {
          currentMonthTotal += sip.amount;
          currentMonthSips.add(sip);
        }
      }
      if (sip.paymentDate.year == nextYear.year) {
        nextYearTotal += sip.amount;
        nextYearSips.add(sip);
      }
      if (sip.paymentDate.year == nextMonth.year && sip.paymentDate.month == nextMonth.month) {
        nextMonthTotal += sip.amount;
        nextMonthSips.add(sip);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Sips'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimen.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(
                title: 'Current Month',
                total: currentMonthTotal,
                sips: currentMonthSips,
              ),
              const SizedBox(height: AppDimen.defaultPadding),
              _buildSummaryCard(
                title: 'Next Month',
                total: nextMonthTotal,
                sips: nextMonthSips,
              ),
              const SizedBox(height: AppDimen.defaultPadding),
              _buildSummaryCard(
                title: 'Current Year',
                total: currentYearTotal,
                sips: currentYearSips,
              ),
              const SizedBox(height: AppDimen.defaultPadding),
              _buildSummaryCard(
                title: 'Next Year',
                total: nextYearTotal,
                sips: nextYearSips,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double total,
    required List<UpcomingSipPaymentVO> sips,
  }) {
    return Card(
      margin: const EdgeInsets.all(AppDimen.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title Summary', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: AppDimen.defaultPadding),
            Text('Total Amount: ${formatToCurrency(total)}'),
            const SizedBox(height: AppDimen.defaultPadding),
            ...sips.map((sip) => _upcomingSipWidget(context: context, sipVo: sip)).toList(),
          ],
        ),
      ),
    );
  }

  @override
  UpcomingSipsPresenter initializePresenter() {
    return UpcomingSipsPresenter();
  }

  Widget _upcomingSipWidget(
      {required final BuildContext context, required final UpcomingSipPaymentVO sipVo}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sipVo.name),
                  Text('Amount: ${sipVo.amount}'),
                  Text('Next Payment Date: ${formatDate(sipVo.paymentDate)}')
                ],
              )
            ],
          ),
        ));
  }
}
