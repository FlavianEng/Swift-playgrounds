class GameEngine {
    var isExploring = false
    let spaceship: Spaceship
    let logger: Logger
    let availableActions: [GameAction] = [Navigate(), ViewCargo(), GoHome()]
    let minerals: [Mineral] = [Iron(), Quartz(), Feldspar(), Pyroxene(), Olivine(), Galena(), Sphalerite(), Palladium(), Painite(), Claudite()]

    init() {
        self.logger = Logger()

        logger.displayTitle()
        let spaceshipName = logger.inputString(message: "Aye Aye, name your spaceship Captain!", confirmMessage: "That's a great name Captain!")

        self.spaceship = Spaceship(name: spaceshipName)
    }
}
