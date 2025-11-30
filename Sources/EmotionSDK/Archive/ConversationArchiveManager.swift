//
//  ConversationArchiveManager.swift
//  EmotionSDK
//
//  📂 格納場所:
//      EmotionSDK/Archive/ConversationArchiveManager.swift
//
//  🎯 ファイルの目的:
//      - ユーザーとの会話ログを最大10年間保存する基盤。
//      - Calendarホルダー構造 (Documents/Calendar/YYYY/MM/DD.json) に格納。
//      - 代表的な会話のみを抽出して保存。
//      - EmotionTypeやトピックをメタ情報として付与。
//      - 長期保存により「記録 → 振り返り → 成長」の循環を支える。
//
//  🔗 依存:
//      - ConversationEntry.swift（会話モデル）
//      - Foundation（ファイル操作）
//      - CalendarHolder（保存先パスユーティリティ）
//
//  👤 制作者: 津村 淳一
//  📅 作成日: 2025年11月30日
//

import Foundation

public final class ConversationArchiveManager {
    public static let shared = ConversationArchiveManager()
    private init() {}

    /// 会話ログを保存（Calendar/YYYY/MM/DD.json）
    public func save(entry: ConversationEntry) {
        let folder = CalendarHolder.urlForTodayFolder(named: "Conversation")
        let fileURL = folder.appendingPathComponent("\(entry.id).json")

        let dict: [String: Any] = [
            "id": entry.id.uuidString,
            "speaker": entry.speaker,
            "text": entry.text,
            "emotion": entry.emotion,
            "topic": entry.topic.label,
            "language": entry.language,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]

        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            try data.write(to: fileURL)
        } catch {
            print("⚠️ 保存失敗: \(error)")
        }
    }
}
