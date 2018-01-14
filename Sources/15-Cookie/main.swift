import Foundation
import AdventLib

struct Ingredient {
    let capacity: Int
    let durability: Int
    let flavor: Int
    let texture: Int
    let calories: Int
}

var ingredients = [String: Ingredient]()

let inputStrings = TextFile.standardInput().readLines()

for inputString in inputStrings {

    let regex = try! Regex(pattern: "([a-zA-Z]+): capacity (-?\\d+), durability (-?\\d+), flavor (-?\\d+), texture (-?\\d+), calories (-?\\d+)")
    guard let match = regex.match(input: inputString) else { continue }

    let name = match[0]
    let ingredient = Ingredient(capacity: Int(match[1])!, durability: Int(match[2])!,
                                flavor: Int(match[3])!, texture: Int(match[4])!, calories: Int(match[5])!)

    ingredients[name] = ingredient
}

print(ingredients)
func recipeTemplates(n: Int, r: Int) -> [[Int]] {

    if n == 1 {
        return [[r]]
    }

    var result = [[Int]]()
    for i in 0 ... r {
        for recipe in recipeTemplates(n: n - 1, r: r - i) {
            var base = [i]
            base.append(contentsOf: recipe)
            result.append(base)
        }
    }

    return result
}

let templates = recipeTemplates(n: ingredients.count, r: 100)

let ingredientNames = Array(ingredients.keys)

var recipes = [[String: Int]]()

for template in templates {
    var recipe = [String: Int]()
    for (index, value) in template.enumerated() {
        recipe[ingredientNames[index]] = value
    }
    recipes.append(recipe)
}

print("Recipes: \(recipes.count)")

typealias Recipe = [String: Int]

func score(recipe: Recipe) -> Int {
    var capacity = 0
    var durability = 0
    var flavor = 0
    var texture = 0
    var calories = 0

    for (ingredientName, quantity) in recipe {
        guard let ingredient = ingredients[ingredientName] else { return -1 }

        capacity += ingredient.capacity * quantity
        durability += ingredient.durability * quantity
        flavor += ingredient.flavor * quantity
        texture += ingredient.texture * quantity
        calories += ingredient.calories * quantity
    }

    guard calories == 500 else { return 0 }
    guard capacity > 0 && durability > 0 && flavor > 0 && texture > 0 else { return 0 }

    return capacity * durability * flavor * texture
}

let scores: [(Recipe, Int)] = recipes.map { ($0, score(recipe: $0)) }

let winner = scores.sorted { $0.1 > $1.1 }.first

print(winner ?? "No winner found")
