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
    guard let match = regex.match(inputString) else { continue }

    let name = match[0]
    let ingredient = Ingredient(capacity: Int(match[1])!, durability: Int(match[2])!,
        flavor: Int(match[3])!, texture: Int(match[4])!, calories: Int(match[4])!)

    ingredients[name] = ingredient
}

func recipeTemplates(n: Int, r: Int) -> [[Int]] {

    if n == 1 {
        return [[r]]
    }

    var result = [[Int]]()
    for i in 0...r {
        for recipe in recipeTemplates(n - 1, r: r - i) {
            var base = [i]
            base.appendContentsOf(recipe)
            result.append(base)
        }
    }

    return result
}

let templates = recipeTemplates(2, r: 10)
print(templates)

let ingredientNames = Array(ingredients.keys)

var recipes = [[String: Int]]()

for template in templates {
    var recipe = [String: Int]()
    for (index, value) in template.enumerate() {
        recipe[ingredientNames[index]] = value
    }
    recipes.append(recipe)
}

print(recipes)

//var scores [([String: Int], Int)]()
//for recipe in recipes {
//
//x}
