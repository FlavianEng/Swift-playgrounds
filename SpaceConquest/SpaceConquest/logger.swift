import Foundation

class Logger {
    func displayTitle() {
        print("""
  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~

(  S  p  a  c  e     C  o  n  q  u  e  s  t  )

  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~
 *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*  *~*.*
~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~  ~*.*~


""")
    }

    func inputString(message: String) -> String {
        print(message)
        let optionalString = readLine()

        if let string = optionalString, string.contains(/\w+/) {
            return string
        }

        print("Please enter a valid string")
        return inputString(message: message)
    }

    func clearConsole() {
        print("\u{1B}[2J") // Clears the entire screen.
        print("\u{1B}[H") // Moves the cursor to the home position (top-left corner).
    }
}
