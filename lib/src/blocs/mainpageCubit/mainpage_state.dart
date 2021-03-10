part of 'mainpage_cubit.dart';

class MainPageState extends Equatable {
  final currenIndex;
  final Widget? bodyPage;
  MainPageState.initialIndex({this.currenIndex = 0, this.bodyPage});
  MainPageState.indexChange({this.currenIndex, this.bodyPage});
  List<Object?> get props => [currenIndex];
}
