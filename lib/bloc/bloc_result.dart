
class BlocResult<T> {

  static const INIT = 0;
  static const EMPTY = 1;
  static const SUCCESS = 2;
  static const ERROR = 3;
  static const OTHER = 4;

  int state;
  T data;
  String errorCode;
  String errorMessage;

  BlocResult.init() {
    this.state = BlocResult.INIT;
  }

  BlocResult.empty() {
    this.state = BlocResult.EMPTY;
  }

  BlocResult.success({T data}) {
    this.state = BlocResult.SUCCESS;
    this.data = data;
  }

  BlocResult.errors(String errorCode, String errorMessage) {
    this.state = BlocResult.ERROR;
    this.errorMessage = errorMessage;
    this.errorCode = errorCode;
  }

  BlocResult.error(String errorMessage) {
    this.state = BlocResult.ERROR;
    this.errorMessage = errorMessage;
  }

  BlocResult.other({T data}) {
    this.state = BlocResult.OTHER;
    this.data = data;
  }
}
