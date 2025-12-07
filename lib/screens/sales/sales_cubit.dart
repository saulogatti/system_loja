import 'package:bloc/bloc.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit() : super(const SalesState());
}
