import Foundation

func jsonObjectSum(json: Any) -> Int {
    var result = 0

    if let dict = json as? [String: AnyObject] {
        for value in dict.values {
            if let word = value as? String,
                word == "red" {
                return 0
            }
            result += jsonObjectSum(json: value)
        }
    } else if let arr = json as? [AnyObject] {
        for value in arr {
            result += jsonObjectSum(json: value)
        }
    } else if let value = json as? NSNumber {
        result += value.intValue
    }

    return result
}

let data = FileHandle.standardInput.readDataToEndOfFile()

let json = try! JSONSerialization.jsonObject(with: data, options: [])

print(jsonObjectSum(json: json))
