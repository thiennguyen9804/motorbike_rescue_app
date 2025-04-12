// instruction_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';

class InstructionCubit extends Cubit<List<InstructionUi>> {
  InstructionCubit() : super([]);

  // Cập nhật các chỉ dẫn
  void updateInstructions(List<InstructionUi> instructions) {
    emit(List<InstructionUi>.from(instructions));
  }
}
