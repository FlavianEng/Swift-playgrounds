import Foundation

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

let escapeCharacter = "\u{001B}"

struct Theme {
    var graphicMode: graphicMode?
    var foregroundColor: xtermColors?
    var backgroundColor: xtermColors?
}

class Logger {
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
    }

    func displayTitle() {
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
    }

    func inputString(message: String, confirmMessage: String?, errorMessage: String = "Please enter a valid string") -> String {
        themedPrint(message)
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

    func clearConsole() {
        print("\u{1B}[2J") // Clears the entire screen.
        print("\u{1B}[H") // Moves the cursor to the home position (top-left corner).
    }

    func themedPrint(_ messages: String..., themes: Theme...) {
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

        print(stringToPrint)
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
