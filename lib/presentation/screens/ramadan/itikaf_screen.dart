import 'package:flutter/material.dart';
import 'package:dharma/presentation/utils/header.dart';

class ItikafScreen extends StatefulWidget {
  const ItikafScreen({Key? key}) : super(key: key);

  @override
  State<ItikafScreen> createState() => _ItikafScreenState();
}

class _ItikafScreenState extends State<ItikafScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ScrollController _scrollController;
  final List<bool> _isExpandedList = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'ইতিকাফ',
          style: TextStyle(fontSize: responsiveFontSize(context, 0.05)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _controller,
                child: child,
              );
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      responsiveWidth(context, 0.05),
                      responsiveHeight(context, 0.05),
                      responsiveWidth(context, 0.05),
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Hero(
                          tag: 'itikaf_header',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(responsiveWidth(context, 0.06)),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ইতিকাফ: তাৎপর্য ও নিয়মাবলী',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsiveFontSize(context, 0.05),
                                    ),
                                  ),
                                  SizedBox(height: responsiveHeight(context, 0.015)),
                                  Text(
                                    'ইতিকাফ একটি গুরুত্বপূর্ণ ইবাদত যা রমজান মাসের শেষ দশকে পালন করা হয়',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveFontSize(context, 0.035),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 0.03)),
                      ],
                    ),
                  ),
                ),
                
                // Information Sections
                SliverList(
                  delegate: SliverChildListDelegate([
                    _buildExpandableSection(
                      context: context,
                      index: 0,
                      title: 'ইতিকাফের তাৎপর্য',
                      icon: Icons.star_border_rounded,
                      content: Text(
                        'ইতিকাফ শব্দের অর্থ হলো কোনো স্থানে আবদ্ধ হয়ে থাকা। শরিয়তের পরিভাষায়, ইতিকাফ বলা হয় আল্লাহর সন্তুষ্টির উদ্দেশ্যে রমজানের শেষ দশ দিন মসজিদে বা কোনো নির্জন স্থানে নিজেকে আবদ্ধ রাখা এবং ইবাদতে মশগুল থাকা।',
                        style: TextStyle(fontSize: responsiveFontSize(context, 0.04), height: 1.5),
                      ),
                    ),
                    
                    _buildExpandableSection(
                      context: context,
                      index: 1,
                      title: 'ইতিকাফের নিয়মাবলী',
                      icon: Icons.rule_rounded,
                      content: Column(
                        children: [
                          _buildRuleItem(
                            context: context, 
                            text: 'ইতিকাফের জন্য পবিত্র হওয়া জরুরি',
                            iconColor: Colors.green,
                          ),
                          _buildRuleItem(
                            context: context, 
                            text: 'পুরুষদের জন্য মসজিদে ইতিকাফ করা উত্তম',
                            iconColor: Colors.green,
                          ),
                          _buildRuleItem(
                            context: context, 
                            text: 'মহিলারা নিজ ঘরে ইতিকাফ করতে পারেন',
                            iconColor: Colors.green,
                          ),
                          _buildRuleItem(
                            context: context, 
                            text: 'ইতিকাফ অবস্থায় বেশি বেশি কুরআন তেলাওয়াত, জিকির ও দোয়া করা উচিত',
                            iconColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    
                    _buildExpandableSection(
                      context: context,
                      index: 2,
                      title: 'ইতিকাফের প্রকারভেদ',
                      icon: Icons.category_outlined,
                      content: Column(
                        children: [
                          _buildTypeItem(
                            context: context,
                            title: 'ওয়াজিব ইতিকাফ',
                            description: 'রমজানের শেষ দশ দিনে এই ইতিকাফ করা হয়।',
                          ),
                          SizedBox(height: responsiveHeight(context, 0.015)),
                          _buildTypeItem(
                            context: context,
                            title: 'সুন্নত ইতিকাফ',
                            description: 'এটিও রমজানের শেষ দশ দিনে করা হয়।',
                          ),
                          SizedBox(height: responsiveHeight(context, 0.015)),
                          _buildTypeItem(
                            context: context,
                            title: 'নফল ইতিকাফ',
                            description: 'যেকোনো সময় এই ইতিকাফ করা যায়।',
                          ),
                        ],
                      ),
                    ),
                    
                    _buildExpandableSection(
                      context: context,
                      index: 3,
                      title: 'নিষিদ্ধ কর্মসমূহ',
                      icon: Icons.block_outlined,
                      content: Column(
                        children: [
                          _buildRuleItem(
                            context: context, 
                            text: 'অপ্রয়োজনীয় কথা ও কাজ থেকে বিরত থাকা',
                            iconColor: Colors.red,
                            iconData: Icons.close_rounded,
                          ),
                          _buildRuleItem(
                            context: context, 
                            text: 'মহিলাদের সাথে দেখা করা থেকে বিরত থাকা',
                            iconColor: Colors.red,
                            iconData: Icons.close_rounded,
                          ),
                          _buildRuleItem(
                            context: context, 
                            text: 'দুনিয়া সংক্রান্ত আলোচনা থেকে দূরে থাকা',
                            iconColor: Colors.red,
                            iconData: Icons.close_rounded,
                          ),
                        ],
                      ),
                    ),
                    
                    // Bottom padding
                    SizedBox(height: responsiveHeight(context, 0.05)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top with animation
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }

  Widget _buildExpandableSection({
    required BuildContext context,
    required int index,
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        responsiveWidth(context, 0.05),
        responsiveHeight(context, 0.01),
        responsiveWidth(context, 0.05),
        responsiveHeight(context, 0.01),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 500 + (index * 200)),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isExpandedList[index]
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ExpansionTile(
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _isExpandedList[index] = expanded;
                  });
                },
                initiallyExpanded: index == 0, // First section expanded by default
                collapsedBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                leading: Container(
                  padding: EdgeInsets.all(responsiveWidth(context, 0.02)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Theme.of(context).primaryColor),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: responsiveFontSize(context, 0.04),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                childrenPadding: EdgeInsets.fromLTRB(
                  responsiveWidth(context, 0.04),
                  0,
                  responsiveWidth(context, 0.04),
                  responsiveHeight(context, 0.02),
                ),
                children: [
                  content,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem({
    required BuildContext context, 
    required String text,
    required Color iconColor,
    IconData iconData = Icons.check_circle_outline_rounded,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsiveHeight(context, 0.015)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: iconColor, size: responsiveWidth(context, 0.05)),
          SizedBox(width: responsiveWidth(context, 0.03)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: responsiveFontSize(context, 0.04), height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeItem({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(responsiveWidth(context, 0.04)),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: responsiveFontSize(context, 0.04),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: responsiveHeight(context, 0.005)),
          Text(
            description,
            style: TextStyle(
              fontSize: responsiveFontSize(context, 0.035),
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
