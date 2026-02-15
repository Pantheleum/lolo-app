/// Subscription tiers for the LOLO app.
enum SubscriptionTier {
  free('free', 'Free'),
  pro('pro', 'Pro'),
  elite('elite', 'Elite');

  final String value;
  final String displayName;

  const SubscriptionTier(this.value, this.displayName);
}
