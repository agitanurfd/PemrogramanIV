import 'package:dio_initial/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserCreate? userCreate;
  final UserUpdate? userUpdate;

  const UserCard({
    super.key,
    required this.userCreate,
    required this.userUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: 400,
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          if (userCreate?.id != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 80,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: Text(
                    ': ${userCreate?.id}',
                  ),
                ),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  userCreate?.name != null
                      ? ': ${userCreate?.name}'
                      : ': ${userUpdate?.name}',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'Job',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  userCreate?.job != null
                      ? ': ${userCreate?.job}'
                      : ': ${userUpdate?.job}',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  userCreate?.createdAt != null ? 'Created At' : 'Updated At',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  userCreate?.createdAt != null
                      ? ': ${userCreate?.createdAt}'
                      : ': ${userUpdate?.updatedAt}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
