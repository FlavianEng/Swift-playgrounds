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
    case systemForeground = "39"
    case systemBackground = "49"
    case pastelYellow = "11"
    case pastelBlue = "12"
    case brightBlue = "45"
    case deepBlack = "232"
}

enum  graphicMode: String {
    case bold = "1"
    case dim = "2"
    case italic = "3"
}

let escapeCharacter = "\u{001B}"

class Logger {
    func displayTitle() {
let starStyle = getStyle(graphicMode: nil, foregroundColor: .pastelYellow, backgroundColor: nil)

        print("""
\(starStyle)
  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~

\(getStyle(graphicMode: .bold, foregroundColor: .pastelBlue, backgroundColor: nil))(  S  p  a  c  e     C  o  n  q  u  e  s  t  )

\(starStyle)  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
""")
    }

    func inputString(message: String, confirmMessage: String?) -> String {
        coloredPrint(message, graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .pastelYellow)
        let optionalString = readLine()

        if let string = optionalString, string.contains(/\w+/) {
            if let confirmMessage = confirmMessage {
                coloredPrint(confirmMessage, graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .pastelYellow)
            }

            return string
        }

        coloredPrint("Please enter a valid string", graphicMode: nil, foregroundColor: nil, backgroundColor: nil)
        return inputString(message: message, confirmMessage: confirmMessage)
    }

    func clearConsole() {
        print("\u{1B}[2J") // Clears the entire screen.
        print("\u{1B}[H") // Moves the cursor to the home position (top-left corner).
    }

    func coloredPrint(_ message: String, graphicMode: graphicMode?, foregroundColor: xtermColors?, backgroundColor: xtermColors?) {
        print("\(getStyle(graphicMode: graphicMode, foregroundColor: foregroundColor, backgroundColor: backgroundColor))\(message)\(resetStyles())")
    }

    func getStyle(graphicMode: graphicMode?, foregroundColor: xtermColors?, backgroundColor: xtermColors?) -> String {
        return "\(escapeCharacter)[0\(setGraphicMode(graphicMode))\(foreground(foregroundColor))\(background(backgroundColor))m"
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
}
