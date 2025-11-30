# EmotionSDK

## 📖 概要
**EmotionSDK** は、ユーザーとの会話や行動を「感情の記録・振り返り・成長」に結びつけるための中核モジュールです。  
単なるログ保存にとどまらず、**長期的なアーカイブ・カレンダー形式での振り返り・代表的な会話抽出・AIコンパニオン自身の成長フィードバック**を統合的に提供します。  

---

## ✨ 特徴
- **ConversationArchiveManager**  
  ユーザーとの会話を最大10年間保存し、日付ごとに整理。  
- **CalendarReflectionService**  
  カレンダー表記で過去の会話を振り返り、「◯ヶ月前にこんな話をしましたね」と共感的に提示。  
- **ConversationPointExtractor**  
  複数会話から代表的な1件を抽出し、効率的に振り返り可能。  
- **CompanionGrowthEngine**  
  内示的に成長指標を蓄積し、たまに振り返り＋共感＋提案を生成。  

---

## 📦 インストール
Swift Package Manager (SPM) を利用してプロジェクトに追加できます。

```swift
dependencies: [
    .package(url: "https://github.com/your-org/EmotionSDK.git", from: "1.0.0")
]
```

---

## 🚀 使用例

### 会話ログの保存
```swift
let entry = ConversationEntry(
    id: UUID(),
    speaker: "user",
    text: "今日は少し疲れています。",
    emotion: "sad",
    topic: "health",
    language: "ja-JP"
)

ConversationArchiveManager.shared.save(entry: entry)
```

### カレンダー振り返り
```swift
if let reflection = CalendarReflectionService().reflect(on: Date(timeIntervalSinceNow: -60*60*24*30)) {
    print(reflection) // "1ヶ月前に『今日は少し疲れています。』について話しましたね。覚えていますか？"
}
```

### 成長フィードバック
```swift
let logs = [EmotionLog(text: "今日は楽しい！", emotion: "happy")]
let feedback = CompanionGrowthEngine.shared.occasionalReflection(from: logs)
print(feedback)
// "あの時は『今日は楽しい！』と感じていましたね。今振り返ると状況は少し変わっています。..."
```

---

## 📂 構成
```
EmotionSDK/
 ├─ Models/
 │   ├─ EmotionType.swift
 │   ├─ EmotionLog.swift
 │   └─ ConversationEntry.swift
 ├─ Archive/
 │   └─ ConversationArchiveManager.swift
 ├─ Reflection/
 │   ├─ CalendarReflectionService.swift
 │   └─ ConversationPointExtractor.swift
 ├─ Growth/
 │   └─ CompanionGrowthEngine.swift
 ├─ Engines/
 │   └─ EmotionClassifierEngine.swift
 ├─ Logging/
 │   └─ MedicationEmotionLogger.swift
 └─ Tests/
     └─ EmotionSDKTests.swift
```

---

## 📜 ライセンス
EmotionSDK は MIT ライセンスの下で公開されています。詳細は [LICENSE](./LICENSE) を参照してください。  

---

👉 この README をベースにすれば、開発者が **EmotionSDK の目的・使い方・構造**をすぐに理解できます。  

次は、この README に **「連携する他SDK（CompanionVoiceSDK / CompanionSpeechSDK / CompanionsSDK）」との関係図**を追加して、全体像をさらに分かりやすくしましょうか？
