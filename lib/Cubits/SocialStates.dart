abstract class SocialStates {}

class SocialInitialState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error ;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialUploadProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}
class SocialUploadProfileImagePickedErrorState extends SocialStates{}
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}
class SocialUploadCoverImagePickedSuccessState extends SocialStates{}
class SocialUploadCoverImagePickedErrorState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateProfileLoadingState extends SocialStates{}
class SocialUserUpdateCoverLoadingState extends SocialStates{}

//create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}


class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}


class SocialRemovePostImageState extends SocialStates{}


class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error ;
  SocialGetPostsErrorState(this.error);
}
class SocialLikePostsSuccessState extends SocialStates{}
class SocialLikePostsLoadingState extends SocialStates{}
class SocialLikePostsErrorState extends SocialStates{
  final String error ;
  SocialLikePostsErrorState(this.error);
}
class SocialCommentOnPostsSuccessState extends SocialStates{}
class SocialCommentOnPostsLoadingState extends SocialStates{}
class SocialCommentOnPostsErrorState extends SocialStates{
  final String error ;
  SocialCommentOnPostsErrorState(this.error);
}


class SocialCommentPostsSuccessState extends SocialStates{}
class SocialCommentPostsLoadingState extends SocialStates{}
class SocialCommentPostsErrorState extends SocialStates{
  final String error ;
  SocialCommentPostsErrorState(this.error);
}
class SocialGetCommentPostsSuccessState extends SocialStates{}
class SocialGetCommentPostsLoadingState extends SocialStates{}
class SocialGetCommentPostsErrorState extends SocialStates{
  final String error ;
  SocialGetCommentPostsErrorState(this.error);
}


class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String error ;
  SocialGetAllUserErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}

