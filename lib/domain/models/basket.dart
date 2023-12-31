import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Basket {
  final int id;
  final String name;
  final List<Investment> investments;

  Basket({required this.id, required this.name, required this.investments});

  static Basket from(
      {required final BasketDO basket,
      required final List<Investment> investments}) {
    return Basket(id: basket.id, name: basket.name, investments: investments);
  }

  double get totalValue {
    return investments.fold(0, (previousValue, investment) {
      return previousValue + investment.value;
    });
  }

  int get investmentCount {
    return investments.length;
  }
}
