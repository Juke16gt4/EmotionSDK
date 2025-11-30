//
//  ConversationPointExtractor.swift
//  EmotionSDK
//
//  📂 格納場所:
//      EmotionSDK/Reflection/ConversationPointExtractor.swift
//
//  🎯 ファイルの目的:
//      - 複数会話から代表的な1件を抽出する。
//      - 感情強度やテキスト長をスコアリングして最も特徴的な会話を選択。
//      - 保存時や振り返り時に「その日の代表会話」として利用。
//      - 長期保存の効率化とユーザーへの分かりやすい提示を支える。
//
//  🔗 依存:
//      - ConversationEntry.swift（会話モデル）
//      - Foundation
//
//  👤 制作者: 津村 淳一
//  📅 作成日: 2025年11月30日
//

import Foundation

public final class ConversationPointExtractor {
    public init() {}

    /// 複数会話から代表的な1件を抽出
    public func extractRepresentative(from entries: [ConversationEntry]) -> ConversationEntry? {
        guard !entries.isEmpty else { return nil }

        let scored = entries.map { entry in
            let score = entry.text.count + (entry.emotion == "happy" ? 10 : 0)
            return (entry, score)
        }

        return scored.max(by: { $0.1 < $1.1 })?.0
    }
}
