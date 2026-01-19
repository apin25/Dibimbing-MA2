enum NavigationRoutes {
  movieList(name: '/movie/list'),
  movieDetail(name: '/movie/detail'),
  favourite(name: '/movie/favourite');

  const NavigationRoutes({ required this.name });
  final String name;
}