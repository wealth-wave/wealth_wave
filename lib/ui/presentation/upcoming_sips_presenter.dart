import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/sip_service.dart';

class UpcomingSipsPresenter extends Presenter<UpcomingSipsViewState> {
  final InvestmentService _investmentService;
  final SipService _sipService;

  UpcomingSipsPresenter(
      {final InvestmentService? investmentService,
      final SipService? sipService})
      : _investmentService = investmentService ?? InvestmentService(),
        _sipService = sipService ?? SipService(),
        super(UpcomingSipsViewState());

  void fetchUpcomingSips() {
    _investmentService.get().then((investments) {
      _sipService.getAll().then((sips) {
        final List<UpcomingSipPaymentVO> futurePayments = sips.expand((sip) {
          Investment investment = investments.firstWhere(
              (investment) => investment.id == sip.investmentId);
          return sip.getFuturePayment(till: DateTime.now().add(const Duration(days: 365))).map((e) => UpcomingSipPaymentVO.from(investment: investment, payment: e));
        }).toList();
        futurePayments.sort((a, b) => a.paymentDate.compareTo(b.paymentDate));
        updateViewState((viewState) {
          viewState.upcomingSipPayments = futurePayments;
        });
      });
    });
  }
}

class UpcomingSipsViewState {
  List<UpcomingSipPaymentVO> upcomingSipPayments = [];
}

class UpcomingSipPaymentVO {
  final String name;
  final double amount;
  final DateTime paymentDate;

  UpcomingSipPaymentVO._(
      {required this.name, required this.amount, required this.paymentDate});

  factory UpcomingSipPaymentVO.from(
      {required final Investment investment, required final Payment payment}) {
    return UpcomingSipPaymentVO._(
        name: investment.name,
        amount: payment.amount,
        paymentDate: payment.createdOn);
  }
}
