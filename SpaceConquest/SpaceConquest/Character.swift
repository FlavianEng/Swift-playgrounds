class Character {
    let emoji: String?
    let isPlayer: Bool
    let logger: Logger

    init(emoji: String?, isPlayer: Bool, logger: Logger) {
        self.emoji = emoji
        self.isPlayer = isPlayer
        self.logger = logger
    }

    func speak(words: String) {
        print("\(escapeCharacter)[0;1m\(words)")
    }
}

class Captain: Character {
    convenience init() {
            self.init(emoji: "🧑", isPlayer: true, logger: Logger())
    }

    override func speak(words: String) {
        print("\(escapeCharacter)[0;1;38;5;45m    \(words) <\(emoji!)")
    }
}

class Narrator: Character {
    convenience init() {
        self.init(emoji: "👤", isPlayer: true, logger: Logger())
    }

    override func speak(words: String) {
        print("\(escapeCharacter)[0;1;38;5;232;48;5;11m\(emoji!)> \(words)")
    }
}
