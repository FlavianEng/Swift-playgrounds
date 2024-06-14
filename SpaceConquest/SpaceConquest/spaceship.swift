// TODO: Move player and first mate in a new "Crew" property in spaceship
class Spaceship {
    let name: String
    let logger: Logger
    var hullStrength: Int = 50
    var cargoHold: [String: Int] = [:]

    init(name: String, logger: Logger) {
        self.name = name
        self.logger = logger
    }

    func takeDamage(amount: Int) {
        hullStrength -= amount
    }

    func collectMineral(name: String, quantity: Int) {
        if var mineralStock = cargoHold[name] {
            mineralStock += quantity

            return
        }

        cargoHold[name] = quantity
    }

    func displayStatus() {
        let blackOnWhiteTheme = Theme(graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .white)
        let blueOnWhiteTheme = Theme(graphicMode: .bold, foregroundColor: .deepBlue, backgroundColor: .white)
        let itemTitle = Theme(graphicMode: .bold, foregroundColor: nil, backgroundColor: nil)

        logger.newLine()
        logger.themedPrint(" ** ", name, " ** ", themes: blackOnWhiteTheme, blueOnWhiteTheme)
        logger.themedPrint("Hull strength: ", String(hullStrength), themes: itemTitle, logger.theme)
        logger.themedPrint("Cargo hold: ", "Empty", themes: itemTitle, logger.theme)
    }

    func navigate() -> Bool {
        let asteroid = Asteroid()
        takeDamage(amount: asteroid.inflictedDamage)

        print("You've taken \(asteroid.inflictedDamage) damage\(asteroid.inflictedDamage > 1 ? "s" : "")")

        if hullStrength <= 0 {
            explode()
            return true
        }

        return false
    }

    private func explode() {
        logger.themedPrint("\n💀 Your spaceship explode and no one will remember you ", themes: Theme(graphicMode: .bold, foregroundColor: .red, backgroundColor: .deepBlack))
    }
}
