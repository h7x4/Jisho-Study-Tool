abstract class NavigationState {
  const NavigationState();
}

class NavigationPage extends NavigationState {
  final int pageNum;
  const NavigationPage(this.pageNum);

}