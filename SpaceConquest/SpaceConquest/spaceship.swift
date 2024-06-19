// TODO: Move player and first mate in a new "Crew" property in spaceship
class Spaceship {
    let name: String
    let logger: Logger
    var hullStrength: Int = 50
    var cargoHold: [Mineral: Int] = [:]
    private lazy var repairMaterials: ([Int], Set<Mineral>) = getRepairMaterial()

    init(name: String, logger: Logger) {
        self.name = name
        self.logger = logger
    }

    func takeDamage(amount: Int) {
        hullStrength -= amount
    }

    func displayStatus() {
        let blackOnWhiteTheme = Theme(graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .white)
        let blueOnWhiteTheme = Theme(graphicMode: .bold, foregroundColor: .deepBlue, backgroundColor: .white)
        let itemTitle = Theme(graphicMode: .bold, foregroundColor: nil, backgroundColor: nil)

        logger.newLine()
        logger.themedPrint(" ** ", name, " ** ", themes: blackOnWhiteTheme, blueOnWhiteTheme)
        logger.themedPrint("Hull strength: ", String(hullStrength), themes: itemTitle, logger.theme)
        logger.themedPrint("Cargo hold: ", themes: itemTitle)

        if cargoHold.isEmpty {
            logger.themedPrint("  Your cargo hold is empty")
            return
        }

        for (mineral, numberInStock) in cargoHold {
            logger.themedPrint("  - ", "\(mineral.name.capitalized): ", String(numberInStock), themes: logger.theme, itemTitle, logger.theme)
        }
    }

    func navigate(asteroid: Asteroid) -> Bool {
        takeDamage(amount: asteroid.inflictedDamage)

        print("You've taken \(asteroid.inflictedDamage) damage\(asteroid.inflictedDamage > 1 ? "s" : "")")

        if hullStrength <= 0 {
            explode()
            return true
        }

        return false
    }

    func collectMineral(asteroid: Asteroid) -> (Int, Mineral) {
        let (numberCollected, mineralType) = asteroid.mineVein()

        if cargoHold[mineralType] == nil {
            cargoHold[mineralType] = 0
        }

        if let numberInStock = cargoHold[mineralType] {
            cargoHold[mineralType] = numberInStock + numberCollected
        }

        return (numberCollected, mineralType)
    }

    func calculateScore() {
        var score = 0

        for (mineral, quantity) in cargoHold {
            score += mineral.value * quantity
        }

        score += hullStrength * 2

        logger.themedPrint("\n🏆 Your score is \(score)", themes: Theme(graphicMode: .bold, foregroundColor: .pastelYellow, backgroundColor: .deepBlack))
    }

    func repair() {
        for (index, mineral) in repairMaterials.1.enumerated() {
            guard let mineralQuantity = cargoHold[mineral] else {
                print("You don't have enough materials to repair your spaceship! – You don't have \(repairMaterials.0[index]) \(mineral.name)")
                return
            }

            if mineralQuantity < repairMaterials.0[index] || (mineralQuantity - repairMaterials.0[index]) < 0 {
                print("You don't have enough materials to repair your spaceship! – You don't have \(repairMaterials.0[index]) \(mineral.name)")
                return
            }
        }

        print("You have used:")
        for (index, mineral) in repairMaterials.1.enumerated() {
            print("  - ", repairMaterials.0[index], " ", mineral.name)
            if let mineralQuantity = cargoHold[mineral] {
                cargoHold[mineral] = mineralQuantity - repairMaterials.0[index]
            }
        }

        hullStrength = 50
        repairMaterials = getRepairMaterial()
    }

    private func getRepairMaterial() -> ([Int], Set<Mineral>) {
        let neededQuantity = [3, 1, 1]
        var neededMinerals = Set<Mineral>()

        for _ in 0..<3 {
            neededMinerals.insert(Mineral.getRandomMineral())
        }

        return (neededQuantity, neededMinerals)
    }

    private func explode() {
        logger.themedPrint("\n💀 Your spaceship explode and no one will remember you ", themes: Theme(graphicMode: .bold, foregroundColor: .red, backgroundColor: .deepBlack))

        calculateScore()
    }
}
