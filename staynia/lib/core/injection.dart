import 'package:get_it/get_it.dart';
import 'package:staynia/data/repository/address_repository.dart';
import 'package:staynia/data/repository/booking_repository.dart';
import 'package:staynia/data/repository/category_repository.dart';
import 'package:staynia/data/repository/document_repository.dart';
import 'package:staynia/data/repository/impl/address_repository_impl.dart';
import 'package:staynia/data/repository/impl/booking_repository_impl.dart';
import 'package:staynia/data/repository/impl/category_repository_impl.dart';
import 'package:staynia/data/repository/impl/document_repository_impl.dart';
import 'package:staynia/data/repository/impl/room_repository_impl.dart';
import 'package:staynia/data/repository/impl/user_repository_impl.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/data/repository/user_repository.dart';
import 'package:staynia/providers/manager/address/address_cubit.dart';
import 'package:staynia/providers/manager/auth/auth_cubit.dart';
import 'package:staynia/providers/manager/category/manager/category_cubit.dart';
import 'package:staynia/providers/manager/document/document_cubit.dart';
import 'package:staynia/providers/manager/locale/locale_cubit.dart';
import 'package:staynia/providers/manager/user/refresh_token/refresh_token_cubit.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/screens/admin/booking/manager/booking_manager_cubit.dart';
import 'package:staynia/screens/admin/room/manager/list_room/list_room_cubit.dart';
import 'package:staynia/screens/admin/dashboard/manager/dashboard_cubit.dart';
import 'package:staynia/screens/admin/room/manager/create_room_cubit.dart';
import 'package:staynia/screens/admin/room/manager/update/update_room_cubit.dart';
import 'package:staynia/screens/auth/register/manager/register_cubit.dart';
import 'package:staynia/screens/booking/manager/booking_detail/booking_detail_cubit.dart';
import 'package:staynia/screens/booking/manager/request_to_book_cubit.dart';
import 'package:staynia/screens/bookings/manager/booking_cubit.dart';
import 'package:staynia/screens/detail_room/manager/detailroom_cubit.dart';
import 'package:staynia/screens/home/manager/room_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  //* Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl());
  sl.registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl());
  sl.registerLazySingleton<DocumentRepository>(() => DocumentRepositoryImpl());
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl());

  //* Bloc & Cubit
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  sl.registerFactory<DetailRoomCubit>(
    () => DetailRoomCubit(sl<RoomRepository>()),
  );
  sl.registerLazySingleton<RefreshTokenCubit>(
    () => RefreshTokenCubit(sl(), sl()),
  );
  sl.registerFactory<AddressCubit>(() => AddressCubit(sl<AddressRepository>()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<UserRepository>()));
  sl.registerLazySingleton<UserBloc>(() => UserBloc(sl(), sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
  sl.registerFactory<RoomCubit>(() => RoomCubit(sl()));
  sl.registerFactory<DocumentCubit>(
    () => DocumentCubit(sl<DocumentRepository>()),
  );
  sl.registerFactory<CreateRoomCubit>(
    () => CreateRoomCubit(sl<RoomRepository>(), sl<DocumentRepository>()),
  );
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(sl<RoomRepository>()),
  );
  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(sl<CategoryRepository>()),
  );
  sl.registerFactory<ListRoomCubit>(() => ListRoomCubit(sl<RoomRepository>()));
  sl.registerFactory<RequestToBookCubit>(
    () => RequestToBookCubit(sl<BookingRepository>()),
  );
  sl.registerFactory<BookingCubit>(() => BookingCubit(sl<BookingRepository>()));
  sl.registerFactory<BookingManagerCubit>(
    () => BookingManagerCubit(sl<BookingRepository>()),
  );
  sl.registerFactory<BookingDetailCubit>(
    () => BookingDetailCubit(sl<BookingRepository>()),
  );
  sl.registerFactory<UpdateRoomCubit>(
    () => UpdateRoomCubit(sl<RoomRepository>(), sl<DocumentRepository>()),
  );
}
