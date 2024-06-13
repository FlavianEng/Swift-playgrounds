class Character {
    let name: String
    let emoji: String?
    let logger: Logger
    let prefix: String
    let theme: Theme

    init(name: String, emoji: String?, theme: Theme) {
        self.emoji = emoji
        self.logger = Logger(theme: theme)
        self.name = name
        self.theme = theme

        if let definedEmoji = emoji {
            self.prefix = "\(definedEmoji) \(name) > "
            return
        }

        self.prefix = ""
    }

    func speak(words: String) {
        logger.themedPrint("\(prefix + words)")
    }

    func ask(question message: String, answerOnceAnswered confirmMessage: String) -> String {
        return logger.inputString(message: "\(prefix + message)", confirmMessage: "\(prefix + confirmMessage)")
    }
}

class Captain: Character {
    convenience init() {
        self.init(name: "You", emoji: "🧑", theme: Theme(graphicMode: .bold, foregroundColor: .pastelBlue, backgroundColor: nil))
    }
}

class FirstMate: Character {
    convenience init() {
        self.init(name: "First mate", emoji: "👤", theme: Theme(graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .pastelYellow))
    }

    override func ask(question message: String, answerOnceAnswered confirmMessage: String) -> String {
        return logger.inputString(message: "\(prefix + message)", confirmMessage: "\(prefix + confirmMessage)", errorMessage: "You can't be serious! What's the real spaceship name Captain?")
    }
}
