//import ANSITerminal

class GameEngine {
    var isExploring = false
    let spaceship: Spaceship
    let availableActions: [GameAction] = [Navigate(), ViewCargo(), GoHome()]
    let minerals: [Mineral] = [Iron(), Quartz(), Feldspar(), Pyroxene(), Olivine(), Galena(), Sphalerite(), Palladium(), Painite(), Claudite()]

    init(spaceship: Spaceship) {
        self.spaceship = spaceship
    }
}
