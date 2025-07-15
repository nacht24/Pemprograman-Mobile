// FILE: lib/pages/comment.dart

import 'package:flutter/material.dart';
import 'package:mobiledev/controllers/controller_comment.dart';
import 'package:mobiledev/models/model_comment.dart';

class CommentPage extends StatelessWidget {
  final int postId;

  const CommentPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return FutureBuilder<List<Comment>>(
          future: fetchComments(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: \${snapshot.error}'));
            } else {
              final comments = snapshot.data!;
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const SizedBox(height: 4),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: comments.length,
                        separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16),
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(comment.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.body),
                                const SizedBox(height: 4),
                                Text(
                                  comment.email,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}