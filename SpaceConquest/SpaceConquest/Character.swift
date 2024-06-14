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

    func ask(question message: String, answerOnceAnswered confirmMessage: String, inputName: String = "", errorMessage: String = "What?") -> String {
        return logger.inputString(message: "\(prefix + message)", confirmMessage: "\(prefix + confirmMessage)", inputName: inputName, errorMessage: errorMessage)
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
}
