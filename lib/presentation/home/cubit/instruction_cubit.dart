// instruction_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';

class InstructionCubit extends Cubit<InstructionUi?> {
  InstructionCubit() : super(null);

  // Cập nhật các chỉ dẫn
  void updateInstruction(InstructionUi instructions) {
    emit(instructions);
  }
}
