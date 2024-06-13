class GameEngine {
    var isExploring = false
    let spaceship: Spaceship
    let logger: Logger
    let firstMate: FirstMate
    let player: Captain
    let availableActions: [GameAction] = [Navigate(), ViewCargo(), GoHome()]
    let minerals: [Mineral] = [Iron(), Quartz(), Feldspar(), Pyroxene(), Olivine(), Galena(), Sphalerite(), Palladium(), Painite(), Claudite()]

    init() {
        self.logger = Logger(theme: Theme(graphicMode: nil, foregroundColor: nil, backgroundColor: nil))
        self.firstMate = FirstMate()
        self.player = Captain()

        logger.displayTitle()
        let spaceshipName = firstMate.ask(question: "Aye Aye, name your spaceship Captain!", answerOnceAnswered: "Aye Aye Captain!")

        self.spaceship = Spaceship(name: spaceshipName, logger: logger)

        firstMate.speak(words: "Here's the info about your spaceship!")
        spaceship.displayStatus()
    }
}
