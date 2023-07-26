import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/features/search/repository/search_repository.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, bool>((ref) {
  final searchRepository = ref.watch(searchRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return SearchController(
    searchRepository: searchRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final searchUsersProvider = StreamProvider.family((ref, String typedUser) {
  return ref.watch(searchControllerProvider.notifier).searchUsers(typedUser);
});

final searchSliderListsProvider = StreamProvider((ref) {
  return ref.watch(searchControllerProvider.notifier).searchSliderLists();
});

final productImagesSliderListsListsProvider = StreamProvider((ref) {
  return ref.watch(searchControllerProvider.notifier).productImagesSliderLists();
});

final topPostListsProvider = StreamProvider((ref) {
  return ref.watch(searchControllerProvider.notifier).topPostLists();
});

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  SearchController({
    required SearchRepository searchRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _searchRepository = searchRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  Stream<List<Post>> productImagesSliderLists() {
    return _searchRepository.productImagesSliderLists();
  }

  Stream<List<Post>> searchSliderLists() {
    return _searchRepository.getSearchSliderLists();
  }

  Stream<List<Post>> topPostLists() {
    return _searchRepository.getTopPostLists();
  }

  Stream<List<UserModel>> searchUsers(String typedUser) {
    return _searchRepository.getSearchUsers(typedUser);
  }
}
