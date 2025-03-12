import 'package:flutter/material.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('দান ও সাদাকাহ'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'রমজান দান গাইড',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'রমজানে সাদাকাহর গুরুত্ব:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
              'রমজানে, সাদাকাহ দেওয়ার গুরুত্ব অপরিমেয়। আল্লাহ কুরআনে দানের গুরুত্বের উপর জোর দিয়েছেন, যারা উদারভাবে দান করে তাদের জন্য বড় পুরস্কারের প্রতিশ্রুতি দিয়েছেন। নবী মুহাম্মদ (সাঃ) রমজানে সবচেয়ে বেশি দানশীল ছিলেন।'),
          const SizedBox(height: 10),
          const Text(
            'আল্লাহ কি বলেন:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
              'কুরআনে দানের গুণাবলী সম্পর্কে বিভিন্ন আয়াতে উল্লেখ আছে, যেখানে আল্লাহ এই বরকতময় মাসে ভালো কাজের প্রতিদান বাড়িয়ে দেন।'),
          const SizedBox(height: 10),
          const Text(
            'নবী কি বলেন:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
              'নবী (সাঃ) বলেছেন, "শ্রেষ্ঠ দান হল রমজানে দেওয়া দান।" তিনি আরও জোর দিয়েছেন যে সাদাকাহ সম্পদকে পবিত্র করে এবং মানুষকে আল্লাহর কাছে নিয়ে যায়।'),
          const SizedBox(height: 20),
          const Text(
            'সাদাকাহ দেওয়ার উপায়:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('অভাবীদের জন্য ইফতারের ব্যবস্থা করুন'),
          ),
          const ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('স্বনামধন্য দাতব্য প্রতিষ্ঠানে দান করুন'),
          ),
          const ListTile(
            leading: Icon(Icons.volunteer_activism),
            title: Text('সময় এবং প্রচেষ্টা দিয়ে সাহায্য করুন'),
          ),
          const ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('যারা কষ্টে আছে তাদের সহায়তা করুন'),
          ),
          // const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     // Implement donation logic here
          //   },
          //   child: const Text('এখন দান করুন'),
          // ),
        ],
      ),
    );
  }
}
