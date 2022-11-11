import 'package:climb_balance/presentation/ai_feedback/models/ai_score_per_frame.dart';

double? perFrameScoreAvg({
  required AiScorePerFrame aiScorePerFrame,
  required int idx,
}) {
  int count = 0;
  double sumScore = 0;
  if (aiScorePerFrame.inertia[idx] != null) {
    sumScore += aiScorePerFrame.inertia[idx]!;
    count += 1;
  }
  if (aiScorePerFrame.balance[idx] != null) {
    sumScore += aiScorePerFrame.balance[idx]!;
    count += 1;
  }
  if (aiScorePerFrame.accuracy[idx] != null) {
    sumScore += aiScorePerFrame.accuracy[idx]!;
    count += 1;
  }
  if (aiScorePerFrame.angle[idx] != null) {
    sumScore += aiScorePerFrame.angle[idx]!;
    count += 1;
  }
  if (aiScorePerFrame.moment[idx] != null) {
    sumScore += aiScorePerFrame.moment[idx]!;
    count += 1;
  }
  if (count == 0) return null;
  return sumScore / count;
}
