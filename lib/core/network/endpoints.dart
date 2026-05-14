class AuthEndPoint {
  static const baseUrl = "https://flower.elevateegy.com/api/v1";
  static const signIn = "/auth/signin";
  static const signUp = "/auth/signup";

  static const forgotPassword = "/auth/forgotPassword";
  static const verifyResetCode = "/auth/verifyResetCode";
  static const resetPassword = "/auth/resetPassword";
  static const profile = "/auth/profile-data";
}

class ProductsSectionsEndPoint {
  static const categories = "/categories";
  static const occasions = "/occasions";
  static const products = "/products";
  static const productById = "/products/{id}";
}
