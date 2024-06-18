enum asteroidSize {
    case tiny
    case small
    case normal
    case big
    case huge
}

// TODO: Add a better way to handle percentage
class Asteroid {
    lazy var size: asteroidSize = getSize()
    lazy var inflictedDamage: Int = getInflictedDamage(asteroidSize: size)
    lazy var vein: Mineral = getVein()
    var hasBeenCollected = false

    func mineVein() -> (Int, Mineral) {
        guard hasBeenCollected == false else {
            return (0, vein)
        }

        hasBeenCollected = true
        return (3, vein)
    }

    /// Chance of apparition
    /// tiny 45% / small 25% / normal 15% / big 10% / huge 5%
    private func getSize() -> asteroidSize {
        switch Int.random(in: 1 ... 100) {
        case 45..<70:
            return .small
        case 70..<85:
            return .normal
        case 85..<95:
            return .big
        case 95...100:
            return .huge
        default:
            return .tiny
        }
    }

    private func getInflictedDamage(asteroidSize: asteroidSize) -> Int {
        switch asteroidSize {
        case .tiny:
            return 1
        case .small:
            return 4
        case .normal:
            return 8
        case .big:
            return 15
        case .huge:
            return 25
        }
    }

    /// Chance of apparition
    /// Claudite 2% / Palladium 5% / Sphalerite 10% / Olivine 20% / Feldspar 25% / Iron 38%
    private func getVein() -> Mineral {
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
