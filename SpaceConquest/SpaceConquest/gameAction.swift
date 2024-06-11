protocol GameAction {
    var label: String { get }
    func action()
}

class Navigate: GameAction {
    let label = "Navigate"

    func action() {

    }
}

class ViewCargo: GameAction {
    let label = "View cargo"

    func action() {

    }
}

class GoHome: GameAction {
    let label = "Go home"

    func action() {

    }
}
