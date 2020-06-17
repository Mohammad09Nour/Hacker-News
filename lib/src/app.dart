import 'package:flutter/material.dart';
import 'blocs/stories_provider.dart';
import 'screens/homeScreen.dart';
import 'screens/news_details.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                      color: Colors.purpleAccent,
            ),
          ),
          title: "Hello",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        if (settings.name == '/') {
          final bloc = StoriesProvider.of(context);
         bloc.fetchTopIds();
          return HomeScreen();
        }
        final commentsBloc = CommentsProvider.of(context);
        final int id = int.parse(settings.name.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(id);
        return NewsDetails(id);
      },
    );
  }
}
