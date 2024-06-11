class Mineral {
    let name: String
    let value: Int

    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
}

class Iron: Mineral {
    convenience init() {
        self.init(name: "Iron", value: 1)
    }
}

class Quartz: Mineral {
    convenience init() {
        self.init(name: "Quartz", value: 2)
    }
}

class Feldspar: Mineral {
    convenience init() {
        self.init(name: "Feldspar", value: 3)
    }
}

class Pyroxene: Mineral {
    convenience init() {
        self.init(name: "Pyroxene", value: 4)
    }
}

class Olivine: Mineral {
    convenience init() {
        self.init(name: "Olivine", value: 5)
    }
}

class Galena: Mineral {
    convenience init() {
        self.init(name: "Galena", value: 6)
    }
}

class Sphalerite: Mineral {
    convenience init() {
        self.init(name: "Sphalerite", value: 7)
    }
}

class Palladium: Mineral {
    convenience init() {
        self.init(name: "Palladium", value: 8)
    }
}

class Painite: Mineral {
    convenience init() {
        self.init(name: "Painite", value: 9)
    }
}

class Claudite: Mineral {
    convenience init() {
        self.init(name: "Claudite", value: 10)
    }
}
