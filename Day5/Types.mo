import Result "mo:base/Result";

module {
  public type StudentProfile = {
    name : Text;
    team : Text;
    graduate : Bool;
  };

  public type TestResult = Result.Result<(), TestError>;
  public type TestError = {
    #UnexpectedValue : Text;
    #UnexpectedError : Text;
  };
};
