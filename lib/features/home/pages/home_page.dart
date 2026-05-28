import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../sheets/create_space_sheet.dart';

import '../services/space_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SpaceService();

    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mementales",
        ),
      ),

      floatingActionButton:
        FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor:
            Colors.transparent,
            builder: (_) {
            return const
            CreateSpaceSheet();
          },
        );
      },

      child: const Icon(
      Icons.add,
      ),

      ),

      body: StreamBuilder(
        stream: FirebaseFirestore
            .instance
            .collection("spaces")
            .where(
              "members",
              arrayContains: userId,
            )
            .snapshots(),

        builder: (
          context,
          snapshot,
        ) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Space Yet",
              ),
            );
          }

          final spaces =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount:
                spaces.length,

            itemBuilder:
                (context, index) {

              final data =
                  spaces[index];

              return Card(
                margin:
                    const EdgeInsets.all(
                  10,
                ),

                child: ListTile(
                  title: Text(
                    data["name"],
                  ),

                  subtitle: Text(
                    "Budget: Rp ${data["budget"]}",
                  ),

                  trailing:
                      Text(
                    "${data["month"]}/${data["year"]}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}