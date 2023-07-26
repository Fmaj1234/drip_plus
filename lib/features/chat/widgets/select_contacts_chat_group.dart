import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGroupContacts = StateProvider<List<UserModel>>((ref) => []);

class SelectContactsChatGroup extends ConsumerStatefulWidget {
  const SelectContactsChatGroup({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<SelectContactsChatGroup> createState() =>
      _SelectContactsChatGroupState();
}

class _SelectContactsChatGroupState
    extends ConsumerState<SelectContactsChatGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, UserModel usermodel) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    ref
        .read(selectedGroupContacts.notifier)
        .update((state) => [...state, usermodel]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userFollowersProvider).when(
          data: (contactList) => Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                var searchData = contactList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.only(bottom: 2),
                  child: InkWell(
                    onTap: () => selectContact(index, searchData),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image(
                            image: NetworkImage(
                              searchData.profilePic,
                            ),
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchData.username,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Followed by ${searchData.followers.length} people',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (selectedContactsIndex.contains(index))
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.done, color: Colors.grey),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
           error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
        );
  }
}
