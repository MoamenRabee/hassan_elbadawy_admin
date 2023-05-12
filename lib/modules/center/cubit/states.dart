abstract class CenterStates{}

class CenterInitState extends CenterStates {}

class GetCenterStateLoading extends CenterStates {}
class GetCenterStateSuccess extends CenterStates {}
class GetCenterStateErorr extends CenterStates {
  String err;
  GetCenterStateErorr(this.err);
}



class AddCenterStateLoading extends CenterStates {}
class AddCenterStateSuccess extends CenterStates {}
class AddCenterStateErorr extends CenterStates {
  String err;
  AddCenterStateErorr(this.err);
}


class DeleteCenterStateLoading extends CenterStates {}
class DeleteCenterStateSuccess extends CenterStates {}
class DeleteCenterStateErorr extends CenterStates {
  String err;
  DeleteCenterStateErorr(this.err);
}