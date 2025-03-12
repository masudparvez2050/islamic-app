import 'package:flutter/material.dart';

class ItikafScreen extends StatelessWidget {
  const ItikafScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('ইতিকাফ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ইতিকাফ: তাৎপর্য ও নিয়মাবলী',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'ইতিকাফ একটি গুরুত্বপূর্ণ ইবাদত। ইতিকাফ শব্দের অর্থ হলো কোনো স্থানে আবদ্ধ হয়ে থাকা। শরিয়তের পরিভাষায়, ইতিকাফ বলা হয় আল্লাহর সন্তুষ্টির উদ্দেশ্যে রমজানের শেষ দশ দিন মসজিদে বা কোনো নির্জন স্থানে নিজেকে আবদ্ধ রাখা এবং ইবাদতে মশগুল থাকা।',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'ইতিকাফের উদ্দেশ্য',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'ইতিকাফের প্রধান উদ্দেশ্য হলো আল্লাহর নৈকট্য লাভ করা এবং শবে কদর তালাশ করা।',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'ইতিকাফের নিয়মাবলী',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'ইতিকাফের কিছু নিয়মাবলী নিচে উল্লেখ করা হলো:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('ইতিকাফের জন্য পবিত্র হওয়া জরুরি।'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('পুরুষদের জন্য মসজিদে ইতিকাফ করা উত্তম।'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('মহিলারা নিজ ঘরে ইতিকাফ করতে পারেন।'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('ইতিকাফ অবস্থায় বেশি বেশি কুরআন তেলাওয়াত, জিকির ও দোয়া করা উচিত।'),
            ),
            const SizedBox(height: 16),
            Text(
              'ইতিকাফের প্রকারভেদ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'ইতিকাফ মূলত তিন প্রকার:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.arrow_right, color: Colors.blue),
              title: Text('ওয়াজিব ইতিকাফ: রমজানের শেষ দশ দিনে এই ইতিকাফ করা হয়।'),
            ),
            const ListTile(
              leading: Icon(Icons.arrow_right, color: Colors.blue),
              title: Text('সুন্নত ইতিকাফ: এটিও রমজানের শেষ দশ দিনে করা হয়।'),
            ),
            const ListTile(
              leading: Icon(Icons.arrow_right, color: Colors.blue),
              title: Text('নফল ইতিকাফ: যেকোনো সময় এই ইতিকাফ করা যায়।'),
            ),
            const SizedBox(height: 16),
            Text(
              'ইতিকাফের সময় যে কাজগুলো থেকে বিরত থাকা উচিত',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'ইতিকাফের সময় কিছু কাজ থেকে বিরত থাকা উচিত। যেমন:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text('অপ্রয়োজনীয় কথা ও কাজ থেকে বিরত থাকা।'),
            ),
            const ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text('মহিলাদের সাথে দেখা করা থেকে বিরত থাকা।'),
            ),
            const ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text('দুনিয়া সংক্রান্ত আলোচনা থেকে দূরে থাকা।'),
            ),
          ],
        ),
      ),
    );
  }
}
