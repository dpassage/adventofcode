import Foundation

let weapons: [(Int, Int)] = [
/*
 Weapons:    Cost  Damage  Armor
 Dagger        8     4       0
 Shortsword   10     5       0
 Warhammer    25     6       0
 Longsword    40     7       0
 Greataxe     74     8       0
 */
    (8, 4),
    (10, 5),
    (25, 6),
    (40, 7),
    (74, 8)
]

let armors: [(Int, Int)] = [
    /*
 Armor:      Cost  Damage  Armor
 Leather      13     0       1
 Chainmail    31     0       2
 Splintmail   53     0       3
 Bandedmail   75     0       4
 Platemail   102     0       5
 */
    (0, 0),
    (13, 1),
    (31, 2),
    (53, 3),
    (75, 4),
    (102, 5)
]

let rings: [(Int, Int, Int)] = [
    /*
    Rings:      Cost  Damage  Armor
    Damage +1    25     1       0
    Damage +2    50     2       0
    Damage +3   100     3       0
    Defense +1   20     0       1
    Defense +2   40     0       2
    Defense +3   80     0       3
 */
    (25, 1, 0),
    (50, 2, 0),
    (100, 3, 0),
    (20, 0, 1),
    (40, 0, 2),
    (80, 0, 3)
]

struct Combatant {
    var points: Int
    var damage: Int
    var armor: Int

    func beats(other: Combatant) -> Bool {
        let myDamage = max(self.damage - other.armor, 1)
//        let myRounds = (other.points + (1 - myDamage)) / myDamage
        var myRounds = 0
        var otherPoints = other.points
        while otherPoints > 0 {
            myRounds += 1
            otherPoints -= myDamage
        }
        let otherDamage = max(other.damage - self.armor, 1)
//        let otherRounds = (self.points + (1 - otherDamage)) / otherDamage
        var otherRounds = 0
        var myPoints = self.points
        while myPoints > 0 {
            otherRounds += 1
            myPoints -= otherDamage
        }

        return myRounds <= otherRounds
    }
}

var ringChoices: [(Int, Int, Int)] = []
ringChoices.append((0, 0, 0))
ringChoices.append(contentsOf: rings)
for i in 0..<(rings.count - 1) {
    for j in (i + 1)..<rings.count {
        let cost = rings[i].0 + rings[j].0
        let damage = rings[i].1 + rings[j].1
        let armor = rings[i].2 + rings[j].2
        ringChoices.append((cost, damage, armor))
    }
}

var costOfCheapestWin = Int.max
var costOfDearestLoss = Int.min

let boss = Combatant(points: 103, damage: 9, armor: 2)

for weapon in weapons {
    for armor in armors {
        for ring in ringChoices {
            let cost = weapon.0 + armor.0 + ring.0
            let myDamage = weapon.1 + ring.1
            let myArmor = armor.1 + ring.2

            let me = Combatant(points: 100, damage: myDamage, armor: myArmor)
            if me.beats(other: boss) {
                costOfCheapestWin = min(cost, costOfCheapestWin)
            } else {
                costOfDearestLoss = max(cost, costOfDearestLoss)
            }
        }
    }
}

print(costOfCheapestWin, costOfDearestLoss)
// 111: too low
