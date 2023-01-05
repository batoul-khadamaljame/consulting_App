abstract class SearchStates{}

class SearchInitialState extends SearchStates{}


class SearchCategoryLoadingState extends SearchStates{}
class SearchCategorySuccessState extends SearchStates{}
class SearchCategoryErrorState extends SearchStates
{
  final String error;

  SearchCategoryErrorState(this.error);

}

class SearchExpertLoadingState extends SearchStates{}
class SearchExpertSuccessState extends SearchStates{}
class SearchExpertErrorState extends SearchStates
{
  final String error;

  SearchExpertErrorState(this.error);

}
