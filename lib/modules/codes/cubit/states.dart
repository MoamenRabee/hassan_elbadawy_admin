abstract class CodeStates{}

class CodeInitState extends CodeStates {}

class GetGroupStateLoading extends CodeStates {}
class GetGroupStateSuccess extends CodeStates {}
class GetGroupStateErorr extends CodeStates {
  String err;
  GetGroupStateErorr(this.err);
}



class AddGroupStateLoading extends CodeStates {}
class AddGroupStateSuccess extends CodeStates {}
class AddGroupStateErorr extends CodeStates {
  String err;
  AddGroupStateErorr(this.err);
}

class ToArchiveStateLoading extends CodeStates {}
class ToArchiveStateSuccess extends CodeStates {}
class ToArchiveStateErorr extends CodeStates {
  String err;
  ToArchiveStateErorr(this.err);
}

class DeleteStateLoading extends CodeStates {}
class DeleteStateSuccess extends CodeStates {}
class DeleteStateErorr extends CodeStates {
  String err;
  DeleteStateErorr(this.err);
}


class AddCodesLoading extends CodeStates {}
class AddCodesSuccess extends CodeStates {}
class AddCodeOneSuccess extends CodeStates {}
class AddCodesErorr extends CodeStates {
  String err;
  AddCodesErorr(this.err);
}

class GetCodesLoading extends CodeStates {}
class GetCodesSuccess extends CodeStates {}
class GetCodesErorr extends CodeStates {
  String err;
  GetCodesErorr(this.err);
}


class DeleteCodeLoading extends CodeStates {}
class DeleteCodeSuccess extends CodeStates {}
class DeleteCodeErorr extends CodeStates {
  String err;
  DeleteCodeErorr(this.err);
}

class DownloadCodeLoading extends CodeStates {}
class DownloadCodeSuccess extends CodeStates {}
class DownloadCodeErorr extends CodeStates {
  String err;
  DownloadCodeErorr(this.err);
}