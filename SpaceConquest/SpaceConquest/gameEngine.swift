enum GameAction: String, CaseIterable {
    case navigateAndCollectMinerals = "Navigate through asteroids and collect minerals along the way"
    case viewCargo = "View Cargo – See your inventory"
    case goHome = "Go home – Repair spaceship"
    case exitGame = "Exit Game"
}

class GameEngine {
    var isStarted = false
    let spaceship: Spaceship
    let logger: Logger
    let firstMate: FirstMate
    let player: Captain
    let minerals: [Mineral] = [Iron(), Feldspar(), Olivine(), Sphalerite(), Palladium(), Claudite()]
    var asteroid: Asteroid

    init() {
        self.logger = Logger(theme: nilTheme)
        self.firstMate = FirstMate()
        self.player = Captain()
        self.asteroid = Asteroid()

        logger.displayTitle()
        let spaceshipName = firstMate.ask(question: "Aye Aye, name your spaceship Captain!", answerOnceAnswered: "Aye Aye Captain!", inputName: "Spaceship name", errorMessage: "You can't be serious! What's the real spaceship name Captain!")

        self.spaceship = Spaceship(name: spaceshipName, logger: logger)

        start()
    }

    func start() {
        isStarted = true
        while isStarted {
            chooseAction()
            logger.pause()
        }
    }

    func broken() {
        firstMate.speak(words: "Something went wrong Captain, we're gonna die.")
        logger.themedPrint("\n(Game crash – Not your fault – Developer does a poor job)", themes: errorTheme)
    }

    func chooseAction() {
        let indexTheme = Theme(graphicMode: .bold, foregroundColor: nil, backgroundColor: nil)

        firstMate.speak(words: "What do you want to do Captain?\n")

        for (index, action) in GameAction.allCases.enumerated() {
            let actionNumber = index + 1

            logger.themedPrint("\(actionNumber). ", action.rawValue, themes: indexTheme, nilTheme)
        }

        do {
            let action = try logger.inputRange(acceptedValues: GameAction.allCases.map {$0.rawValue})

            var times = 1
            if GameAction.allCases[action] == .navigateAndCollectMinerals {
                times = logger.inputNumber(message: "How many times do you want to repeat action?", defaultValue: 1)
            }

            logger.clearConsole()
            doAction(action: GameAction.allCases[action], asteroid: &asteroid, repeatAction: Int(times))
        } catch {
            broken()
        }
    }

    func doAction(action: GameAction, asteroid: inout Asteroid, repeatAction: Int = 1) {
        for _ in 0..<repeatAction {
            switch action {
            case .viewCargo:
                player.speak(words: "I want to \(action.rawValue.lowercased())")
                spaceship.displayStatus()
                break

            case .navigateAndCollectMinerals:
                player.speak(words: "I want to \(action.rawValue.lowercased())\n")
                let hasExploded = spaceship.navigate(asteroid: asteroid)

                if hasExploded {
                    isStarted = false
                    return
                }

                let (numberCollected, mineralType) = spaceship.collectMineral(asteroid: asteroid)
                firstMate.speak(words: "You've harvest \(numberCollected) of \(mineralType.name)")

                asteroid = Asteroid()
                break

            case .goHome:
                player.speak(words: "Head to home mates!")
                break

            case .exitGame:
                player.speak(words: "See ya!")
                spaceship.calculateScore()
                isStarted = false
                break
            }
        }
    }
}
