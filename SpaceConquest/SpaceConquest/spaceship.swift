class Spaceship {
    let name: String
    var hullStrength: Int = 50
    var cargoHold: [String: Int] = [:]

    init(name: String) {
        self.name = name
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
        print("""
        ** \(name) Spaceship **
        Hull strength: \(hullStrength)
        Cargo hold: \(cargoHold.values)
        """)
    }
}
