import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/provider.dart';


class ReviewDialog extends StatelessWidget {
  ReviewDialog({required this.provider, required this.id});
  final AppProvider provider;
  final String id;

  @override
  Widget build(BuildContext context) {
    var _nameTextController = TextEditingController();
    var _reviewTextController = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text("Add Review"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _nameTextController,
                validator: (value) {
                  if (value!.isEmpty) return "Name required";
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Name",
                    suffixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                controller: _reviewTextController,
                validator: (value) {
                  if (value!.isEmpty ) return "Review required";
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Review",
                    suffixIcon: Icon(Icons.rate_review),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15)),
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending...")));
                Review review = Review(
                  id: id,
                  name: _nameTextController.text,
                  review: _reviewTextController.text, date: '',
                );
                provider.postReview(review).then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success!")));
                  Navigator.pop(context);
                });
              }
            },
            child: Text("Save"))
      ],
    );
  }
}