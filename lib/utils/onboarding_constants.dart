import '../models/onboarding_item.dart';

class OnboardingConstants {
  static const List<OnboardingItem> items = [
    OnboardingItem(
      image: 'lib/assets/Group 1000003937.png',
      title: 'Swipe with real intent.',
      subtitle: 'Every right-swipe locks a tiny, fully-refundable pledge',
      description: 'Just enough friction to make intent explicit.',
    ),
    OnboardingItem(
      image: 'lib/assets/Group 1000003939.png',
      title: 'Mindless swiping costs more than \$\$',
      subtitle: 'Your money stays locked & you lose optionality',
      description: 'Discourages ego swiping, endless chats, and ghosting.',
    ),
    OnboardingItem(
      image: 'lib/assets/Group 1000003940.png',
      title: 'No pay-to-win pressure',
      subtitle:
          'You never see their pledge until yours is locked, so dollars can\'t distract the match.',
      description: 'Double blind fairness',
    ),
    OnboardingItem(
      image: 'lib/assets/Group 1000003945.png',
      title: 'Instant refunds',
      subtitle: 'Meet IRL or unmatch and you get every cent back instantly.',
      description: 'Funds live on Solana blockchain. Never with Swifey',
    ),
    OnboardingItem(
      image: 'lib/assets/Group 1000003946.png',
      title: 'Date decisively & never pay.',
      subtitle: 'Dating should cost courage, not subscriptions.',
      description: 'Decide. Commit. Pay nothing.',
    ),
  ];
}
