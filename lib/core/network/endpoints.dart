class AuthEndPoint {
  static const baseUrl = "https://flower.elevateegy.com/api/v1";
  static const signIn = "/auth/signin";
  static const signUp = "/auth/signup";

  static const forgotPassword = "/auth/forgotPassword";
  static const verifyResetCode = "/auth/verifyResetCode";
  static const resetPassword = "/auth/resetPassword";
  static const profile = "/auth/profile-data";
  static const editProfile = "/auth/editProfile";
  static const uploadPhoto = "/auth/upload-photo";
  static const changePassword = "/auth/change-password";
}

class ProductsSectionsEndPoint {
  static const categories = "/categories";
  static const occasions = "/occasions";
  static const products = "/products";
  static const productById = "/products/{id}";
}

class CartEndPoints {
  static const String cart = '/cart';
  static const String updateCartItem = '/cart/{id}';
  static const String removeCartItem = '/cart/{id}';
}

class NotificationsEndPoints {
  static const String getUserNotifications = '/notifications/user';
  static const String unReadCount = '/notifications/unread-count';
}
