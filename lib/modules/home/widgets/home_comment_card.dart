import 'package:flutter/material.dart';
import 'package:hassan_elbadawy_admin/models/comment_model.dart';
import 'package:hassan_elbadawy_admin/modules/home/cubit/home_cubit.dart';

Widget homeCommentCard(BuildContext context,CommentModel commentModel) {
  return ListTile(
    onTap: () {},
    leading: const CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
    title: Text(commentModel.studentName!),
    subtitle: Text(
      commentModel.comment!,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            HomeCubit.get(context).deleteComment(commentModel);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    ),
  );
}
