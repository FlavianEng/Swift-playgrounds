import Foundation

enum LoggerError: Error {
    case emptyArray
}

/// Documentation
/// https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#colors--graphics-mode

/// Using 256 colors mode : https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#256-colors
enum xtermColors: String {
    case black = "0"
    case red = "1"
    case green = "2"
    case yellow = "3"
    case blue = "4"
    case magenta = "5"
    case cyan = "6"
    case white = "255"
    case pastelYellow = "11"
    case pastelBlue = "12"
    case brightBlue = "45"
    case deepBlack = "232"
    case deepBlue = "25"
}

enum  graphicMode: String {
    case bold = "1"
    case dim = "2"
    case italic = "3"
}

struct Theme {
    var graphicMode: graphicMode?
    var foregroundColor: xtermColors?
    var backgroundColor: xtermColors?
}

let nilTheme = Theme(graphicMode: nil, foregroundColor: nil, backgroundColor: nil)
let errorTheme = Theme(graphicMode: .bold, foregroundColor: .red, backgroundColor: .deepBlack)

let escapeCharacter = "\u{1B}"
let blinkingCursor = "\(escapeCharacter)[1 q\(escapeCharacter)[?25h"

class Logger {
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
    }

    func displayTitle() {
        clearConsole()
        let starTheme = Theme(graphicMode: nil, foregroundColor: .pastelYellow, backgroundColor: nil)
        let starStyle = getStyle(starTheme)

        print("""
\(starStyle)
  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~

\(getStyle(Theme(graphicMode: .bold, foregroundColor: .pastelBlue, backgroundColor: nil)))(  S  p  a  c  e     C  o  n  q  u  e  s  t  )

\(starStyle)  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
""")
        pause()
    }

    func inputString(message: String, confirmMessage: String?, inputName: String = "", errorMessage: String = "Please enter a valid string") -> String {
        themedPrint(message)
        themedPrint("\(inputName): \(blinkingCursor)", themes: nilTheme, terminator: "")

        let optionalString = readLine()

        if let string = optionalString, string.contains(/\w+/) {
            if let confirmMessage = confirmMessage {
                themedPrint(confirmMessage)
            }

            return string
        }

        themedPrint(errorMessage)
        return inputString(message: message, confirmMessage: confirmMessage)
    }

    func inputNumber(message: String, errorMessage: String = "Please enter a valid number", defaultValue: Int? = nil) -> Int {
        themedPrint(message, "\(defaultValue == nil ? "" : " – Default = \(defaultValue!)")")
        themedPrint(blinkingCursor, themes: nilTheme, terminator: "")

        let optionalString = readLine()

        if let string = optionalString {
            if let integer = Int(string), integer > 1 {
                return integer
            }
        }

        if let fallbackValue = defaultValue, fallbackValue > 0 {
            return fallbackValue
        }

        themedPrint(errorMessage)
        return inputNumber(message: message, errorMessage: errorMessage)
    }

    func inputRange( acceptedValues: [String], excludedValues: [String] = [], message: String? = nil, defaultValue: Int? = nil) throws -> Int {
        guard !acceptedValues.isEmpty else {
            throw LoggerError.emptyArray
        }

        var validInputs: [Int] = []
        for (index, value) in acceptedValues.enumerated() {
            if (excludedValues.contains {$0 == value}) {
                continue
            }

            validInputs.append(index)
        }

        themedPrint("\(message == nil ? "Please enter a value among \(validInputs.map {$0 + 1})" : "\(message!) – Accepted inputs: \(validInputs.map {$0 + 1})")", "\(defaultValue != nil ? " – Default: \(defaultValue!)": "") ")
        themedPrint(blinkingCursor, themes: nilTheme, terminator: "")

        let optionalString = readLine()

        guard let string = optionalString else {
            if let fallbackValue = defaultValue {
                return fallbackValue
            }

            print("Input not valid")
            return try inputRange(acceptedValues: acceptedValues, excludedValues: excludedValues)
        }

        if let index = Int(string), validInputs.contains(index - 1) {
            return index - 1
        }

        if let fallbackValue = defaultValue {
            return fallbackValue
        }

        print("Input not valid")
        return try inputRange(acceptedValues: acceptedValues, excludedValues: excludedValues)
    }

    func pause() {
        themedPrint("\nPress enter to continue...", themes: Theme(graphicMode: .dim, foregroundColor: nil, backgroundColor: nil))
        _ = readLine()
        clearConsole()
    }

    func clearConsole() {
        print("\(escapeCharacter)[2J") // Clears the entire screen.
        print("\(escapeCharacter)[H") // Moves the cursor to the home position (top-left corner).
    }

    func themedPrint(_ messages: String..., themes: Theme..., terminator: String = "\n") {
        guard !messages.isEmpty else {
            return
        }

        var defaultTheme = self.theme
        var stringToPrint = ""

        if !themes.isEmpty {
            defaultTheme = themes[0]
        }

        messages.enumerated().forEach { (index, message) in
            var messageTheme = defaultTheme
            if themes.indices.contains(index) {
                messageTheme = themes[index]
            }

            stringToPrint += getThemedString(message, theme: messageTheme)
        }

        print(stringToPrint, terminator: terminator)
    }

    func getThemedString(_ message: String, theme: Theme? = nil) -> String {
        var themeToUse = self.theme

        if let givenTheme = theme {
            themeToUse = givenTheme
        }

        return "\(getStyle(themeToUse))\(message)\(resetStyles())"
    }

    func getStyle(_ theme: Theme) -> String {
        return "\(escapeCharacter)[0\(setGraphicMode(theme.graphicMode))\(foreground(theme.foregroundColor))\(background(theme.backgroundColor))m"
    }

    func setGraphicMode(_ graphicMode: graphicMode?) -> String {
        if let mode = graphicMode {
            return ";\(mode.rawValue)"
        }

        return ""
    }

    func foreground(_ color: xtermColors?) -> String {
        if let foregroundColor = color {
            return ";38;5;\(foregroundColor.rawValue)"
        }

        return ""
    }

    func background(_ color: xtermColors?) -> String {
        if let backgroundColor = color {
            return ";48;5;\(backgroundColor.rawValue)"
        }

        return ""
    }

    func resetStyles() -> String {
        return "\(escapeCharacter)[0m"
    }

    func newLine() {
        print("\n")
    }
}
