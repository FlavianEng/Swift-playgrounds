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

class Feldspar: Mineral {
    convenience init() {
        self.init(name: "Feldspar", value: 5)
    }
}

class Olivine: Mineral {
    convenience init() {
        self.init(name: "Olivine", value: 15)
    }
}

class Sphalerite: Mineral {
    convenience init() {
        self.init(name: "Sphalerite", value: 25)
    }
}

class Palladium: Mineral {
    convenience init() {
        self.init(name: "Palladium", value: 35)
    }
}

class Claudite: Mineral {
    convenience init() {
        self.init(name: "Claudite", value: 50)
    }
}
