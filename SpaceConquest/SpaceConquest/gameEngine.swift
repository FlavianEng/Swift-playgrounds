enum GameAction: String, CaseIterable {
    case navigate = "Navigate through asteroids"
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
    let minerals: [Mineral] = [Iron(), Quartz(), Feldspar(), Pyroxene(), Olivine(), Galena(), Sphalerite(), Palladium(), Painite(), Claudite()]

    init() {
        self.logger = Logger(theme: nilTheme)
        self.firstMate = FirstMate()
        self.player = Captain()

        logger.displayTitle()
        let spaceshipName = firstMate.ask(question: "Aye Aye, name your spaceship Captain!", answerOnceAnswered: "Aye Aye Captain!", inputName: "Spaceship name", errorMessage: "You can't be serious! What's the real spaceship name Captain!")

        self.spaceship = Spaceship(name: spaceshipName, logger: logger)

        firstMate.speak(words: "Here's the info about your spaceship!")
        spaceship.displayStatus()
        logger.pause()

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
        firstMate.speak(words: "What do you want to do Captain?\n")

        GameAction.allCases.enumerated().forEach { (index, action) in
            let actionNumber = index + 1

            print("\(actionNumber). \(action.rawValue)")
        }

        do {
            let action = try logger.inputRange(acceptedValues: GameAction.allCases.map {$0.rawValue})

            logger.clearConsole()
            doAction(action: GameAction.allCases[action])
        } catch {
            broken()
        }
    }

    func doAction(action: GameAction) {
        switch action {
        case .viewCargo:
            player.speak(words: "I want to \(action.rawValue.lowercased())")
            spaceship.displayStatus()
            break

        case .navigate:
            player.speak(words: "I want to \(action.rawValue.lowercased())\n")
            let hasExploded = spaceship.navigate()

            if hasExploded {
                isStarted = false
            }
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
