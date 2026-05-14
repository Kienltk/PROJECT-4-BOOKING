class ApiUrl {
  const ApiUrl._();
  //* ------------------------------------------------------------------------------------


  
  static const String login = '/api/auth/login';
  static const String userInfor = '/api/user';
  static const String logout = '/api/user/logout';
  static const String register = '/api/auth/register';
  static const String refreshToken = '/api/auth/refreshToken';
  static const String getAllRoom = '/api/room';
  static const String getDetailRoom = '/api/room/getDetail';
  static const String getProvinces = '/api/auth/address/provinces';
  static const String getDistricts = '/api/auth/address/districts';
  static const String getWards = '/api/auth/address/wards';
  static const String getCategories = '/api/category';
  static const String getCategoryByType = '/api/category/getByType';
  static const String createCategory = '/api/category';
  static const String updateCategory = '/api/category';
  static const String deleteCategory = '/api/category';
  static const String createRoom = '/api/room';
  static const String updateRoom = '/api/room';
  static const String deleteRoom = '/api/room';
  static const String multiUploadDocument = '/api/document/multiUpload';
  static const String uploadDocument = '/api/document';
  static const String updateDocument = '/api/document';
  static const String deleteDocument = '/api/document';
  static const String createBooking = '/api/booking';
  static const String getByRenter = '/api/booking';
  static const String getBookings = '/api/booking/getBookings';
  static const String getBookingDetail = '/api/booking/getBookingDetail';
  static const String getBookingsByRenter = '/api/booking/getBookingsByRenter';
  static const String changeBookingStatus = '/api/booking/changeStatus';
}
