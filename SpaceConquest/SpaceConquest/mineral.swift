class Mineral: Hashable {
    let name: String
    let value: Int

    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }

    // Implement the hash function based on the name property
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    // Implement the equality operator to check if names are equal
    static func == (lhs: Mineral, rhs: Mineral) -> Bool {
        return lhs.name == rhs.name
    }

    /// Chance of apparition
    /// Claudite 2% / Palladium 5% / Sphalerite 10% / Olivine 20% / Feldspar 25% / Iron 38%
    static func getRandomMineral() -> Mineral {
        switch Int.random(in: 0 ... 100) {
        case 1...2:
            return Claudite()
        case 3...8:
            return Palladium()
        case 9...18:
            return Sphalerite()
        case 19...38:
            return Olivine()
        case 39...63:
            return Feldspar()
        default:
            return Iron()
        }
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
