import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../models/user/user.dart';
import '../../core/l10n/app_l10n.dart';
import '../../core/theme/app_text_styles.dart';
import '../../service/network_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<User> _profileInfos() async {
    final data = await Network.request(api: Apis.profile, useToken: true);
    if (data != null) {
      return Network.parseUser(data);
    } else {
      throw Exception("There is a problem with the system, please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text(AppStrings.profile),
      ),
      body: FutureBuilder<User>(
          future: _profileInfos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return Padding(
                padding: AppSizes.paddingAll16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSizes.h24,
                    CircleAvatar(
                      radius: AppSizes.fifty,
                      backgroundImage: CachedNetworkImageProvider(user.avatar),
                    ),

                    AppSizes.h16,
                    ProfileDetailTile(detail: user.name),
                    ProfileDetailTile(detail: user.email),
                    const ProfileDetailTile(detail: AppStrings.birthdate),
                    const ProfileDetailTile(detail: AppStrings.phone),
                    const ProfileDetailTile(detail: AppStrings.address),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}

class ProfileDetailTile extends StatelessWidget {
  final String detail;

  const ProfileDetailTile({required this.detail, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              detail,
              style: AppTextStyles.inputText.copyWith(color: AppColors.grey800),
            ),
            const Icon(Icons.edit, color: AppColors.greyDark),
          ],
        ),
        Divider(color: AppColors.grey200),
        AppSizes.h8,
      ],
    );
  }
}
