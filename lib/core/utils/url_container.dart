class UrlContainer {
  // static const String domainUrl = 'http://192.168.1.17:3000'; //YOUR WEBSITE DOMAIN URL HERE
  static const String domainUrl = 'https://lary-pay-backend.vercel.app'; //YOUR WEBSITE DOMAIN URL HERE
  static const String baseUrl = '$domainUrl/api/';
  static const String loginEndPoint = '$domainUrl/api/auth/longin';
  static const String loginClientEndPoint = 'client/login-client';

  static const String forgetPasswordEndPoint = '$domainUrl/api/auth/longin';
  static const String passwordVerifyEndPoint = '$domainUrl/api/auth/longin';
  static const String resetPasswordEndPoint = '$domainUrl/api/auth/longin';
  static const String validateToken = 'client/validate-token';
  static const String loanApplications = 'loanApplications/create';

  static const String loanFilterEndPoint = 'loanApplications/getByClient';


}
