//
//  MedicationEmotionLogger.swift
//  EmotionSDK
//
//  📂 格納場所:
//      EmotionSDK/Logging/MedicationEmotionLogger.swift
//
//  🎯 ファイルの目的:
//      - EmotionSDK における「服薬関連感情ログ」の専用ロガー。
//      - Companion の発話やユーザー応答に紐づく EmotionType を記録。
//      - 削除不可ログとして永続化し、後から参照・分析可能にする。
//      - ログはタイムスタンプ・言語コード・感情ラベルを含むテキスト形式で保存。
//      - 将来的に CoreData やクラウド同期へ拡張可能な基盤クラス。
//
//  🔗 依存:
//      - EmotionType.swift（感情タイプ定義）
//      - Foundation（ファイル操作・日付フォーマット）
//
//  🔗 関連/連動ファイル:
//      - EmotionLog.swift（CoreDataモデル）
//      - EmotionClassifierEngine.swift（感情推定エンジン）
//      - CompanionAdviceEngine.swift（助言生成エンジン）
//      - EmotionType+Localization.swift（多言語ラベル表示）
//
//  👤 制作者: 津村 淳一
//  📅 改変日: 2025年11月30日
//
//  📝 使用例:
//      MedicationEmotionLogger.shared.log(.happy, language: "ja-JP")
//      → [2025-11-30 11:17] [ja-JP] [感情] うれしい (happy)
//
//  ⚠️ 注意:
//      - ログファイルは「服薬感情ログ.txt」として Documents 配下に保存。
//      - ユーザーが削除できない設計（医療・安全性の観点）。
//      - 実運用では暗号化やアクセス制御を追加することを推奨。
//

import Foundation

public final class MedicationEmotionLogger {
    public static let shared = MedicationEmotionLogger()
    private init() {}

    public func log(_ emotion: EmotionType, language: String) {
        let timestamp = DateFormatter.localizedTimestamp()
        let line = "[\(timestamp)] [\(language)] [感情] \(emotion.label) (\(emotion.rawValue))\n"
        let url = logFileURL()

        if FileManager.default.fileExists(atPath: url.path) {
            append(line, to: url)
        } else {
            create(line, at: url)
        }
    }

    private func logFileURL() -> URL {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return folder.appendingPathComponent("服薬感情ログ.txt")
    }

    private func create(_ text: String, at url: URL) {
        try? text.write(to: url, atomically: true, encoding: .utf8)
    }

    private func append(_ text: String, to url: URL) {
        guard let handle = try? FileHandle(forWritingTo: url) else { return }
        handle.seekToEndOfFile()
        if let data = text.data(using: .utf8) {
            handle.write(data)
        }
        handle.closeFile()
    }
}
