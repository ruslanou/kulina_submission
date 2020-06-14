import 'package:intl/intl.dart';

class Helper {
  String currencyFormatter(number) {
    assert(number != null);
    final NumberFormat numberFormat =
        NumberFormat.currency(locale: "id-ID", symbol: "Rp ");

    return numberFormat.format(number);
  }
}
