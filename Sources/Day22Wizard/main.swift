import Foundation

import AdventLib

enum Spell {
    case missile
    case drain
    case shield
    case poison
    case recharge

    static let spells: [Spell] = [.missile, .drain, .shield, .poison, .recharge]
}

typealias StateChange = (GameState) -> Result

enum Result {
    case playerWon(Int)
    case playerLost
    case keepGoing(GameState)

    func apply(change: StateChange) -> Result {
        switch self {
        case .playerWon(let mana): return .playerWon(mana)
        case .playerLost: return .playerLost
        case .keepGoing(let state): return change(state)
        }
    }
}

struct GameState {
    var myPoints: Int
    var myMana: Int

    var bossPoints: Int
    let bossDamage: Int

    var manaSpent: Int = 0

    var shieldTurns = 0
    var poisonTurns = 0
    var rechargeTurns = 0

    let hard: Bool
    init(bossPoints: Int, bossDamage: Int, myPoints: Int = 50, myMana: Int = 500, hard: Bool = false) {
        self.bossPoints = bossPoints
        self.bossDamage = bossDamage

        self.myPoints = myPoints
        self.myMana = myMana
        self.hard = hard
    }

    func check() -> Result {
        if bossPoints <= 0 { return .playerWon(manaSpent) }
        if myPoints <= 0 { return .playerLost }
        return .keepGoing(self)
    }

    // Cast the indicated spell, then run to the next spell opportunity:
    // * apply effects
    // * boss attack
    // * apply effects
    // After each action, check to see if the game is over.

    func playerCast(spell: Spell) -> Result {
        return cast(spell: spell)
            .apply(change: { $0.applyShield() })
            .apply(change: { $0.applyPoision() })
            .apply(change: { $0.applyRecharge() })
            .apply(change: { $0.bossAttack() })
            .apply(change: { $0.hardPenalty() })
            .apply(change: { $0.applyShield() })
            .apply(change: { $0.applyPoision() })
            .apply(change: { $0.applyRecharge() })
    }

    mutating func spendMana(_ points: Int) {
        myMana -= points
        manaSpent += points
    }

    func cast(spell: Spell) -> Result {
        var newState = self
        switch spell {
        case .missile:
            // Magic Missile costs 53 mana. It instantly does 4 damage.
            guard newState.myMana >= 53 else { return Result.playerLost }
            newState.spendMana(53)
            newState.bossPoints -= 4
            return newState.check()
        case .drain:
            // Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit points.
            guard newState.myMana >= 73 else { return .playerLost }
            newState.spendMana(73)
            newState.bossPoints -= 2
            newState.myPoints += 2
            return newState.check()
        case .shield:
            // Shield costs 113 mana. It starts an effect that lasts for 6 turns.
            // While it is active, your armor is increased by 7.
            guard newState.myMana >= 113 && newState.shieldTurns == 0 else { return .playerLost }
            newState.spendMana(113)
            newState.shieldTurns = 6
            return newState.check()
        case .poison:
            // Poison costs 173 mana. It starts an effect that lasts for 6 turns.
            // At the start of each turn while it is active, it deals the boss 3 damage.
            guard newState.myMana >= 173 && newState.poisonTurns == 0 else { return .playerLost }
            newState.spendMana(173)
            newState.poisonTurns = 6
            return newState.check()
        case .recharge:
            guard newState.myMana >= 229 && newState.rechargeTurns == 0 else { return .playerLost }
            newState.spendMana(229)
            newState.rechargeTurns = 5
            return newState.check()
        }
    }

    func bossAttack() -> Result {
        var newState = self
        let armor = (newState.shieldTurns == 0) ? 0 : 7
        let damage = max(bossDamage - armor, 1)
        newState.myPoints -= damage
        return newState.check()
    }

    func applyPoision() -> Result {
        guard poisonTurns > 0 else { return self.check() }
        var newState = self
        newState.bossPoints -= 3
        newState.poisonTurns -= 1
        return newState.check()
    }

    func applyShield() -> Result {
        guard shieldTurns > 0 else { return self.check() }
        var newState = self
        newState.shieldTurns -= 1
        return newState.check()
    }

    func applyRecharge() -> Result {
        guard rechargeTurns > 0 else { return self.check() }
        var newState = self
        newState.rechargeTurns -= 1
        newState.myMana += 101
        return newState.check()
    }

    func hardPenalty() -> Result {
        guard hard else { return self.check() }
        var newState = self
        newState.myPoints -= 1
        return newState.check()
    }
}

let startingState = GameState(bossPoints: 71, bossDamage: 10, myPoints: 50, myMana: 500, hard: true)

var heap = Heap<GameState>(priorityFunction: { $0.manaSpent < $1.manaSpent })
heap.enqueue(startingState)

while let next = heap.dequeue() {
    print(heap.count)

    for spell in Spell.spells {
        let result = next.playerCast(spell: spell)
        switch result {
        case .playerWon(let mana):
            print("player won! spent \(mana) mana")
            exit(0)
        case .playerLost:
            break
        case .keepGoing(let state):
            heap.enqueue(state)
        }
    }
}

print("no result found!")
