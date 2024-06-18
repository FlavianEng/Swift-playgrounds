enum GameAction: String, CaseIterable {
    case navigate = "Navigate through asteroids"
    case collectMineral = "Collect mineral"
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
            if action == .collectMineral && asteroid.hasBeenCollected {
                continue
            }

            logger.themedPrint("\(actionNumber). ", action.rawValue, themes: indexTheme, nilTheme)
        }

        do {
            let excludedActions = asteroid.hasBeenCollected ? [GameAction.collectMineral.rawValue] : []
            let action = try logger.inputRange(acceptedValues: GameAction.allCases.map {$0.rawValue}, excludedValues: excludedActions)

            logger.clearConsole()
            doAction(action: GameAction.allCases[action], asteroid: &asteroid)
        } catch {
            broken()
        }
    }

    func doAction(action: GameAction, asteroid: inout Asteroid) {
        switch action {
        case .viewCargo:
            player.speak(words: "I want to \(action.rawValue.lowercased())")
            spaceship.displayStatus()
            break

        case .navigate:
            player.speak(words: "I want to \(action.rawValue.lowercased())\n")
            let hasExploded = spaceship.navigate(asteroid: asteroid)

            if hasExploded {
                isStarted = false
            }

            asteroid = Asteroid()
            break

        case .collectMineral:
            player.speak(words: "I want to \(action.rawValue.lowercased())\n")
            let (numberCollected, mineralType) = spaceship.collectMineral(asteroid: asteroid)
            firstMate.speak(words: "You've harvest \(numberCollected) of \(mineralType.name)")
            break

        case .goHome:
            player.speak(words: "Head to home mates!")
            break

        case .exitGame:
            player.speak(words: "See ya!")
            isStarted = false
            break
        }
    }
}
