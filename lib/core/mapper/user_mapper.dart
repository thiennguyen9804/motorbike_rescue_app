import 'package:motorbike_rescue_app/data/dto/local_user.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/data/dto/user_dto.dart';

extension UserDtoX on UserDto {
  LocalUser toLocalUser() {
    return LocalUser(
      id: this.id,
      email: this.email,
      firstName: this.firstName,
      lastName: this.lastName,
      role: this.role.name,  // Chỉ lấy tên role từ Role
    );
  }
}

