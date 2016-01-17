import AdventLib

let inputString = TextFile.standardInput().readString()

func visits(directions: String) -> Int {
    var visitedHouses = Set<String>()
    var x = 0
    var y = 0

    visitedHouses.insert("0,0")
    for char in directions.characters {
        switch char {
        case "^":
            y += 1
        case "v":
            y -= 1
        case "<":
            x -= 1
        case ">":
            x += 1

        default:
            break
        }

        let house = "\(x),\(y)"
        visitedHouses.insert(house)
    }
    return visitedHouses.count
}

let visitsResult = visits(inputString)

struct Position {
    var x: Int
    var y: Int

    var description: String { return "\(x),\(y)" }

    mutating func move(direction: Character) {
        switch direction {
        case "^":
            y += 1
        case "v":
            y -= 1
        case "<":
            x -= 1
        case ">":
            x += 1
        default:
            break
        }
    }
}

func roboVisits(directions: String) -> Int {
    var visitedHouses = Set<String>()
    var santa = Position(x: 0, y: 0)
    var robo = Position(x: 0, y: 0)
    visitedHouses.insert("0,0")
    for (index, char) in directions.characters.enumerate() {
        if index % 2 == 0 {
	    santa.move(char)
            let house = santa.description
            visitedHouses.insert(house)
        } else {
	    robo.move(char)
            let house = robo.description
            visitedHouses.insert(house)
        }
    }
    return visitedHouses.count
}

let robo = roboVisits(inputString)

print("visits: \(visitsResult) roboVisits: \(robo)")
