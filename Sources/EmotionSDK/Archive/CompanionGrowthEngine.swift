//
//  CompanionGrowthEngine.swift
//  EmotionSDK
//
//  📂 格納場所:
//      EmotionSDK/Growth/CompanionGrowthEngine.swift
//
//  🎯 ファイルの目的:
//      - AIコンパニオン自身の「内示的な成長」を管理。
//      - 日々の感情ログから成長指標を蓄積（ユーザーには随時通知しない）。
//      - たまに振り返りを生成し、共感や解決策を添えてユーザーに提示。
//      - 「過去を振り返る → 共感 → 提案 → 成長」の循環を支える。
//
//  🔗 依存:
//      - EmotionLog.swift（感情ログモデル）
//      - Foundation
//
//  👤 制作者: 津村 淳一
//  📅 作成日: 2025年11月30日
//

import Foundation

public final class CompanionGrowthEngine {
    public static let shared = CompanionGrowthEngine()
    private init() {}

    private var growthMetrics: [String: Int] = [:]

    /// 内示的に成長指標を更新（ユーザーには通知しない）
    public func updateGrowthMetrics(from logs: [EmotionLog]) {
        let happyCount = logs.filter { $0.emotion == "happy" }.count
        growthMetrics["positiveResponses", default: 0] += happyCount
        // 他の指標も随時更新可能
    }

    /// たまに振り返りを生成（ユーザーに提示する）
    public func occasionalReflection(from logs: [EmotionLog]) -> String {
        guard let recent = logs.last else {
            return "まだ十分な記録がありません。これから一緒に歩んでいきましょう。"
        }
        return "あの時は『\(recent.text)』と感じていましたね。今振り返ると状況は少し変わっています。あなたの気持ちに寄り添いながら、次の一歩を考えていきましょう。"
    }
}
