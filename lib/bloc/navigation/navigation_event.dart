abstract class NavigationEvent {
  const NavigationEvent();
}

class ChangePage extends NavigationEvent {
  final int pageNum;
  const ChangePage(this.pageNum);
}