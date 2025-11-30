//
//  CalendarReflectionService.swift
//  EmotionSDK
//
//  📂 格納場所:
//      EmotionSDK/Reflection/CalendarReflectionService.swift
//
//  🎯 ファイルの目的:
//      - カレンダー表記で過去の会話を振り返る。
//      - 指定日付の代表的な会話を抽出し、ユーザーに提示。
//      - 「◯ヶ月前にこんな話をしましたね」と共感的に語りかける。
//      - CompanionGrowthEngineと組み合わせて成長フィードバックも可能。
//
//  🔗 依存:
//      - ConversationArchiveManager（保存基盤）
//      - ConversationEntry.swift（会話モデル）
//      - Foundation（ファイル操作）
//
//  👤 制作者: 津村 淳一
//  📅 作成日: 2025年11月30日
//

import Foundation

public final class CalendarReflectionService {
    public init() {}

    /// 指定日付の代表的な会話を振り返りテキストとして返す
    public func reflect(on date: Date) -> String? {
        let folder = CalendarHolder.urlForDateFolder(date: date)
        guard let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil),
              let file = files.first,
              let data = try? Data(contentsOf: file),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let text = json["text"] as? String else {
            return nil
        }

        let monthsAgo = Calendar.current.dateComponents([.month], from: date, to: Date()).month ?? 0
        return "\(monthsAgo)ヶ月前に『\(text)』について話しましたね。覚えていますか？"
    }
}
