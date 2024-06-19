enum GameAction: String, CaseIterable {
    case navigateAndCollectMinerals = "Navigate through asteroids and collect minerals along the way"
    case viewCargo = "View Cargo – See your inventory"
    case repair = "Repair spaceship"
    case howToPlay = "How to play?"
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

            case .repair:
                player.speak(words: "Head to home mates!")
                spaceship.repair()
                break

            case .howToPlay:
                let titleTheme = Theme(graphicMode: .bold, foregroundColor: .deepBlack, backgroundColor: .pastelBlue)
                let subtitleTheme = Theme(graphicMode: .bold, foregroundColor: nil, backgroundColor: nil)

                logger.themedPrint(" How to play? ", themes: titleTheme)
                logger.themedPrint("You're the captain on a spaceship venturing through an asteroid field. Your goal is to navigate safely by dodging asteroids and collecting valuable minerals. Your ship has 50 health points. If your health reaches 0, your ship explodes and the game is over. Your score will be displayed and you can restart the game to beat your best score.\n")

                logger.themedPrint(" Possibles actions: ", themes: titleTheme)
                logger.themedPrint("  - ", "Navigate and collect minerals: ", "As you navigate, you take between 1 and 25 damage and you mine the veins of asteroids in your path. By mining, you obtain a quantity (from 1 to 5) of a type of ore (from among 6 types of ore).", themes: nilTheme, subtitleTheme)
                logger.themedPrint("  - ", "View Cargo: ", "Here you can view your spaceship health and minerals you have in your cargo.", themes: nilTheme, subtitleTheme)
                logger.themedPrint("  - ", "Repair your spaceship: ", "During your navigation, you will suffer damage. You can repair your ship using minerals from your cargo. However, the materials you need to repair your ship are determined randomly. You will need between 1 and 3 types of minerals in the following quantities: 3, 1, 1 (if applicable). If you don't have enough materials, you have to continue to navigate and collect", themes: nilTheme, subtitleTheme)
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
