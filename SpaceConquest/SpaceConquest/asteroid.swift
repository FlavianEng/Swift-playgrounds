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
    lazy var vein: Mineral = Mineral.getRandomMineral()
    var hasBeenCollected = false

    func mineVein() -> (Int, Mineral) {
        guard hasBeenCollected == false else {
            return (0, vein)
        }

        hasBeenCollected = true

        return (Int.random(in: 1...5), vein)
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
}
