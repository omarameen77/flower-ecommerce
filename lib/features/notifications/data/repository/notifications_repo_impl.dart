import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/mapper/notifications_mapper/get_un_read_notification_count_mapper.dart';
import 'package:flower/core/mapper/notifications_mapper/notifications_response_mapper.dart';
import 'package:flower/features/notifications/data/datasource/notifications_remote_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/un_read_count_response.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepoContract)
class NotificationsRepoImpl implements NotificationsRepoContract {
  final NotificationsRemoteDataSourceContract remoteDataSource;

  NotificationsRepoImpl(this.remoteDataSource);
  @override
  Future<BaseResponse<NotificationsResponseEntity>>
  getUserNotifications() async {
    final response = await remoteDataSource.getUserNotifications();
    switch (response) {
      case SuccessBaseResponse<NotificationsResponse>():
        return SuccessBaseResponse<NotificationsResponseEntity>(
          data: response.data.toDomain(),
        );

      case ErrorBaseResponse<NotificationsResponse>():
        return ErrorBaseResponse<NotificationsResponseEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<UnReadCountEntity>> getUnReadNotificationsCount() async {
    final response = await remoteDataSource.getUserNotificationsCount();
    switch (response) {
      case SuccessBaseResponse<UnReadCountResponse>():
        return SuccessBaseResponse<UnReadCountEntity>(
          data: response.data.toDomain(),
        );

      case ErrorBaseResponse<UnReadCountResponse>():
        return ErrorBaseResponse<UnReadCountEntity>(failure: response.failure);
    }
  }
}
