import 'package:motorbike_rescue_app/presentation/home/command/command.dart';

class UserIsEmergencyCommand implements Command {
  @override
  void execute() {
    print('user is in emergency...');
  }

}