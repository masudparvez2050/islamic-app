import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/meditation_progress_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> with SingleTickerProviderStateMixin {
  int _currentStep = 1;
  bool _isLoggedIn = false;
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  final List<MeditationStep> _steps = [
    MeditationStep(
      id: 1,
      title: 'মেডিটেশনের ১ম ধাপ',
      description:
          'মেডিটেশনের ১ম ধাপে ইসলামের ফরজ বিধান এবং গুরুত্বপূর্ণ কিছু সুন্নাত বিধানের প্রতি জোড় দেওয়া হয়েছে। মৌলিকভাবে একজন মুসলমানের জন্য এই আমলগুলো করা জরুরি। এই ধাপে আপনাকে ৫টি করণীয় এবং ৫টি বর্জণীয় আমল দেওয়া হলো। আগামী ৪০ দিন আপনি এই ১০টি আমল গুরুত্বসহ পালন করবেন। তারপর আপনাকে মেডিটেশনের ২য় ধাপে উন্নীত করা হবে, ইন শা আল্লাহ।',
      tasks: [
        'করণীয় ৫টি আমল',
        '১. আল্লাহকে এক বলে মনেপ্রাণে বিশ্বাস করা',
        '২. পাঁচ ওয়াক্ত ফরজ নামাজ আদায় করা',
        '৩. রমজান মাস চলমান হলে লোজা রাখা',
        '৪. আপনার ওপর যাকাত ফরজ হলে তা আদায় করা',
        '৫. দৈনিক অন্তত ১০ বার আল্লাহর কাছে তওবা করা (ইসতেগফার পড়া)',
        '',
        'বর্জনীয় ৫টি আমল',
        '১. গিবত বা অন্যের বদনাম না করা',
        '২. কারো সাথে মিথ্যা না বলা',
        '৩. সবধরনের অশ্লীলতা থেকে দূরে থাকা',
        '৪. কারো হক নষ্ট না করা',
        '৫. সুদী লেনদেন না করা'
      ],
      isLocked: false,
      daysRequired: 40,
    ),
    MeditationStep(
      id: 2,
      title: 'মেডিটেশনের ২য় ধাপ',
      description: 'প্রথম ধাপ সম্পন্ন করার পর আপনি দ্বিতীয় ধাপে উন্নীত হয়েছেন। এই ধাপে আপনাকে আরও গভীর আধ্যাত্মিক অনুশীলনে অংশগ্রহণ করতে হবে।',
      tasks: [
        'করণীয় আমলসমূহ',
        '১. দৈনিক অন্তত একটি নফল নামাজ আদায় করা',
        '২. প্রতিদিন অন্তত ১০ মিনিট কুরআন তিলাওয়াত করা',
        '৩. দৈনিক কমপক্ষে ৫ মিনিট মুরাকাবা (ধ্যান) করা',
        '৪. সপ্তাহে অন্তত একদিন রোজা রাখা',
        '৫. দৈনিক ১০০ বার দুরূদ শরীফ পাঠ করা',
        '',
        'বর্জনীয় আমলসমূহ',
        '১. অপ্রয়োজনীয় কথা না বলা',
        '২. অপ্রয়োজনীয় দেখা না দেখা',
        '৩. অপ্রয়োজনীয় শোনা না শোনা',
        '৪. অযথা সময় নষ্ট না করা',
        '৫. নেতিবাচক চিন্তা থেকে দূরে থাকা'
      ],
      isLocked: true,
      daysRequired: 30,
    ),
    MeditationStep(
      id: 3,
      title: 'মেডিটেশনের ৩য় ধাপ',
      description: 'দ্বিতীয় ধাপ সম্পন্ন করার পর আপনি তৃতীয় ধাপে উন্নীত হয়েছেন। এই ধাপে আধ্যাত্মিক উন্নতির জন্য আরও গভীর অনুশীলন করতে হবে।',
      tasks: [
        'করণীয় আমলসমূহ',
        '১. দৈনিক তাহাজ্জুদ নামাজ আদায় করা',
        '২. প্রতিদিন ৩০ মিনিট কুরআন তিলাওয়াত ও তাফসীর অধ্যয়ন করা',
        '৩. দৈনিক কমপক্ষে ১৫ মিনিট মুরাকাবা (ধ্যান) করা',
        '৪. সপ্তাহে দুইদিন রোজা রাখা',
        '৫. দৈনিক আল্লাহর ৯৯ নাম (আসমাউল হুসনা) পাঠ করা'
      ],
      isLocked: true,
      daysRequired: 30,
    ),
    MeditationStep(
      id: 4,
      title: 'মেডিটেশনের ৪র্থ ধাপ',
      description: 'তৃতীয় ধাপ সম্পন্ন করার পর আপনি চতুর্থ ধাপে উন্নীত হয়েছেন। এই ধাপে আধ্যাত্মিক জ্ঞান ও অভিজ্ঞতা আরও বৃদ্ধি পাবে।',
      tasks: [
        'করণীয় আমলসমূহ',
        '১. দিনে-রাতে মোট ৪০টি নফল নামাজ আদায় করা',
        '২. প্রতিদিন ১ ঘণ্টা কুরআন অধ্যয়ন করা',
        '৩. প্রতিদিন ৩০ মিনিট মুরাকাবা (ধ্যান) করা',
        '৪. সপ্তাহে তিন দিন রোজা রাখা',
        '৫. প্রতিদিন একটি করে ইসলামিক বই পড়া'
      ],
      isLocked: true,
      daysRequired: 20,
    ),
    MeditationStep(
      id: 5,
      title: 'মেডিটেশনের ৫ম ধাপ',
      description: 'চতুর্থ ধাপ সম্পন্ন করার পর আপনি পঞ্চম ও শেষ ধাপে উন্নীত হয়েছেন। এই ধাপে আপনি আধ্যাত্মিক উন্নতির সর্বোচ্চ স্তরে পৌঁছাবেন।',
      tasks: [
        'করণীয় আমলসমূহ',
        '১. প্রতি রাতে তাহাজ্জুদ নামাজে কমপক্ষে ১ ঘণ্টা সময় দেওয়া',
        '২. প্রতিদিন কুরআনের ১ পারা তিলাওয়াত করা',
        '৩. দৈনিক ১ ঘণ্টা মুরাকাবা (ধ্যান) করা',
        '৪. সপ্তাহে চার দিন রোজা রাখা',
        '৫. প্রতিদিন অন্যদের সাহায্য করার জন্য সময় বের করা'
      ],
      isLocked: true,
      daysRequired: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'দৈনিক মেডিটেশন',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.055,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50.withOpacity(0.8),
              Colors.white,
            ],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal.shade300, Colors.teal.shade100],
                  ),
                ),
                child: Center(
                  child: _buildAnimatedWavePattern(screenWidth, screenHeight),
                ),
              ).animate().fadeIn(duration: 800.ms),
            ),
            SliverPadding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildIntroductionSection(screenWidth, screenHeight)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms),
                  SizedBox(height: screenHeight * 0.025),
                  _buildLoginPrompt(screenWidth, screenHeight)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 300.ms)
                      .slideY(begin: 0.2, end: 0),
                  SizedBox(height: screenHeight * 0.025),
                  if (_isLoggedIn)
                    _buildProgressOverview(screenWidth, screenHeight)
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                  SizedBox(height: screenHeight * 0.025),
                  _buildStepsOverview(screenWidth, screenHeight)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms),
                  SizedBox(height: screenHeight * 0.0375),
                  _buildCurrentStepDetails(screenWidth, screenHeight)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 500.ms)
                      .slideY(begin: 0.1, end: 0),
                  SizedBox(height: screenHeight * 0.05),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isLoggedIn) {
            _showCompletionDialog(screenWidth, screenHeight);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('আপনি লগইন করা নেই')),
            );
          }
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.check, size: screenWidth * 0.06),
      ).animate().scale(delay: 700.ms),
    );
  }

  Widget _buildAnimatedWavePattern(double screenWidth, double screenHeight) {
    return CustomPaint(
      size: Size(screenWidth, screenHeight * 0.15),
      painter: WavePainter(_controller),
    );
  }

  void _showCompletionDialog(double screenWidth, double screenHeight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.shade50,
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Icon(
                    Icons.check_circle_outline,
                    size: screenWidth * 0.125,
                    color: Colors.teal.shade700,
                  ),
                ).animate().scale(),
                SizedBox(height: screenHeight * 0.025),
                Text(
                  'আজকের মেডিটেশন সফল!',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  'আপনি আজকের মেডিটেশন অনুশীলন সফলভাবে সম্পন্ন করেছেন। আগামীকাল আবার দেখা হবে!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.075)),
                  ),
                  child: Text(
                    'ধন্যবাদ',
                    style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn().scale();
      },
    );
  }

  Widget _buildProgressOverview(double screenWidth, double screenHeight) {
    final currentStep = _steps.firstWhere((step) => step.id == _currentStep);
    final daysProgress = _getRandomProgress(currentStep.daysRequired);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.0075),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade200],
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Text(
                'আপনার প্রগতি',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01875),
        MeditationProgressCard(
          currentDay: daysProgress,
          totalDays: currentStep.daysRequired,
          stepTitle: currentStep.title,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('মেডিটেশন সময়সূচী দেখুন'),
              ),
            );
          },
        ),
        if (_currentStep < _steps.length)
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01875),
            child: Row(
              children: [
                Icon(Icons.arrow_forward, size: screenWidth * 0.04, color: Colors.teal),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'আগামী ধাপ: ${_steps[_currentStep].title}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildIntroductionSection(double screenWidth, double screenHeight) {
    return GlassmorphicContainer(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Icon(Icons.spa, color: Colors.teal.shade700, size: screenWidth * 0.06),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                'মেডিটেশন (Meditation)',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'মেডিটেশন (Meditation) শব্দের অর্থ- ধ্যান। ধ্যানের পথ ধরে আপনি আধ্যাত্মিকভাবে উন্নতির পথে অগ্রসর হতে পারেন। ধ্যান আপনার দেহ-মনে পরম শান্তি ও স্বস্থি এনে দেবে।',
            style: TextStyle(fontSize: screenWidth * 0.035, height: 1.5),
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: Text(
              'আরো পড়ুন...',
              style: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.w500),
            ),
            children: [
              Text(
                'সঠিক পদ্ধতিতে ধ্যান-সাধনার মাধ্যমে আপনি আল্লাহর কাছাকাছি চলে যেতে পারবেন। আপনার সামনে সৃষ্টির রহস্য উন্মোচিত হলে আপনি স্রষ্টাকে দেখতে পাবেন। তখন নিজের মধ্যে স্রষ্টার উপস্থিতি অনুভব করবেন।\n\nএই মেডিটেশন বা ধ্যান-সাধনার কিছু নিয়ম ও পদ্ধতি রয়েছে। অনুরূপভাবে এর কিছু স্তর ও ধাপ রয়েছে। আমরা এখানে মৌলিক কিছু নিয়ম ও কমন কিছু স্তর নিয়ে আলোচনা করবো। যারা এই মেডিটেশন ও ধ্যান-সাধনায় অংশগ্রহণ করে ধীরে ধীরে নিজেকে উন্নত করতে চান এবং আধ্যাত্ম সাধনা করে পরম সুখ লাভ করতে চান, তাদের জন্য এই ফিচারটি উপকারী হবে, ইন শা আল্লাহ।',
                style: TextStyle(fontSize: screenWidth * 0.035, height: 1.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoggedIn = !_isLoggedIn;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isLoggedIn ? 'আপনি সফলভাবে লগইন করেছেন!' : 'অনুগ্রহ করে লগইন করুন'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.025)),
            margin: EdgeInsets.all(screenWidth * 0.025),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isLoggedIn
                ? [Colors.teal.shade100, Colors.teal.shade50]
                : [Colors.amber.shade100, Colors.amber.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          boxShadow: [
            BoxShadow(
              color: (_isLoggedIn ? Colors.teal : Colors.amber).withOpacity(0.2),
              blurRadius: screenWidth * 0.02,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isLoggedIn ? Icons.verified_user : Icons.login,
                key: ValueKey<bool>(_isLoggedIn),
                color: _isLoggedIn ? Colors.teal.shade700 : Colors.amber.shade800,
                size: screenWidth * 0.07,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                _isLoggedIn
                    ? 'আপনার মেডিটেশন ট্র্যাকিং সক্রিয় আছে'
                    : 'আপনার বিগত দিনের মেডিটেশনের ফলাফল দেখতে অ্যাপে লগইন করুন',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _isLoggedIn ? Colors.teal.shade700 : Colors.amber.shade800,
                  fontSize: screenWidth * 0.0375,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsOverview(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.0075),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade200],
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Text(
                'মেডিটেশনের ধাপসমূহ',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01875),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: screenWidth * 0.025,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _steps.length,
            separatorBuilder: (context, index) => Divider(
              height: screenHeight * 0.00125,
              color: Colors.grey.withOpacity(0.1),
            ),
            itemBuilder: (context, index) {
              final step = _steps[index];
              final isActive = _currentStep == step.id;
              final isCompleted = _currentStep > step.id;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: InkWell(
                  onTap: () {
                    if (!step.isLocked || _isLoggedIn) {
                      setState(() {
                        _currentStep = step.id;
                      });
                      _scrollController.animateTo(
                        screenHeight * 0.8,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('আগের ধাপ সম্পন্ন করার পর এই ধাপে যেতে পারবেন'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.teal.withOpacity(0.05) : Colors.transparent,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isCompleted
                                  ? [Colors.green.shade400, Colors.green.shade500]
                                  : isActive
                                      ? [Colors.teal.shade300, Colors.teal.shade400]
                                      : [Colors.grey.shade200, Colors.grey.shade300],
                            ),
                            boxShadow: [
                              if (isActive || isCompleted)
                                BoxShadow(
                                  color: (isCompleted ? Colors.green : Colors.teal).withOpacity(0.4),
                                  blurRadius: screenWidth * 0.02,
                                  offset: const Offset(0, 2),
                                ),
                            ],
                          ),
                          child: Center(
                            child: isCompleted
                                ? Icon(Icons.check, color: Colors.white, size: screenWidth * 0.05)
                                : Text(
                                    '${step.id}',
                                    style: TextStyle(
                                      color: isActive ? Colors.white : Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                          ),
                        ).animate(target: isActive ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step.title,
                                style: TextStyle(
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                  fontSize: screenWidth * 0.0375,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.0025),
                              Text(
                                '${step.daysRequired} দিনের কোর্স',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: step.isLocked && !_isLoggedIn
                              ? Icon(Icons.lock, color: Colors.grey, size: screenWidth * 0.045)
                              : step.id > _currentStep
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.005),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                      ),
                                      child: Text(
                                        '${step.id - 1}ম ধাপ পরে',
                                        style: TextStyle(fontSize: screenWidth * 0.0275, color: Colors.grey.shade700),
                                      ),
                                    )
                                  : Icon(Icons.arrow_forward_ios, size: screenWidth * 0.035, color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.1, end: 0);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStepDetails(double screenWidth, double screenHeight) {
    final currentStep = _steps.firstWhere((step) => step.id == _currentStep);

    return GlassmorphicContainer(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal.shade300, Colors.teal.shade400],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: screenWidth * 0.02,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  '${currentStep.id}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Text(
                  currentStep.title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn().slideX(begin: -0.1, end: 0),
          SizedBox(height: screenHeight * 0.025),
          Text(
            currentStep.description,
            style: TextStyle(fontSize: screenWidth * 0.0375, height: 1.6),
          ).animate(delay: 100.ms).fadeIn(),
          SizedBox(height: screenHeight * 0.03),
          const Divider(height: 1),
          SizedBox(height: screenHeight * 0.02),
          ...currentStep.tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;

            bool isHeader = !task.startsWith('১') &&
                !task.startsWith('২') &&
                !task.startsWith('৩') &&
                !task.startsWith('৪') &&
                !task.startsWith('৫') &&
                task.isNotEmpty;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0075),
              child: Text(
                task,
                style: TextStyle(
                  fontSize: isHeader ? screenWidth * 0.0425 : screenWidth * 0.0375,
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
                  height: 1.5,
                  color: isHeader ? Colors.teal.shade800 : Colors.black87,
                ),
              ),
            ).animate(delay: (50 * index).ms).fadeIn().slideX(begin: 0.05, end: 0);
          }).toList(),
          SizedBox(height: screenHeight * 0.04),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: ElevatedButton(
                onPressed: _isLoggedIn
                    ? () {
                        _showCompletionDialog(screenWidth, screenHeight);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoggedIn ? Colors.teal : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.075),
                  ),
                  elevation: _isLoggedIn ? 4 : 0,
                  shadowColor: _isLoggedIn ? Colors.teal.withOpacity(0.4) : Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isLoggedIn ? Icons.check_circle : Icons.lock,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      _isLoggedIn ? 'আজকের মেডিটেশন সম্পন্ন করুন' : 'ট্র্যাক করতে লগইন করুন',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
              ),
            ).animate(delay: 400.ms).fadeIn().scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
          ),
        ],
      ),
    );
  }

  int _getRandomProgress(int max) {
    return (_isLoggedIn ? (max * 0.3).round() : 0);
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final height = size.height;
    final width = size.width;

    path.moveTo(0, height * 0.5);

    for (double i = 0; i < width; i++) {
      path.lineTo(
        i,
        height * 0.5 + math.sin((i / width * 4 * math.pi) + animation.value * 2 * math.pi) * height * 0.1,
      );
    }

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);

    final path2 = Path();
    path2.moveTo(0, height * 0.6);

    for (double i = 0; i < width; i++) {
      path2.lineTo(
        i,
        height * 0.6 + math.sin((i / width * 3 * math.pi) + animation.value * 2 * math.pi) * height * 0.05,
      );
    }

    path2.lineTo(width, height);
    path2.lineTo(0, height);
    path2.close();

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: screenWidth * 0.05,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: screenWidth * 0.00375,
        ),
      ),
      child: child,
    );
  }
}

class MeditationStep {
  final int id;
  final String title;
  final String description;
  final List<String> tasks;
  final bool isLocked;
  final int daysRequired;

  MeditationStep({
    required this.id,
    required this.title,
    required this.description,
    required this.tasks,
    required this.isLocked,
    required this.daysRequired,
  });
}