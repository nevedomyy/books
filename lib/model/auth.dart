class AuthResp{
  final bool isSuccess;
  final bool isLoading;

  AuthResp({
    this.isSuccess,
    this.isLoading
  });

  AuthResp.success()
    : isSuccess = true,
      isLoading = false;

  AuthResp.failed()
    : isSuccess = false,
      isLoading = false;

  AuthResp.loading()
    : isSuccess = false,
      isLoading = true;

  AuthResp.initial()
    : isSuccess = false,
      isLoading = false;
}