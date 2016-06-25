import Foundation

func jsonObjectSum(json: AnyObject) -> Int {
    var result = 0

    if let dict = json as? Dictionary<String, AnyObject> {
        for value in dict.values {
            if let word = value as? String where
                word == "red" {
                    return 0
                }
            result += jsonObjectSum(json: value)
        }
    } else if let arr = json as? Array<AnyObject> {
        for value in arr {
            result += jsonObjectSum(json: value)
        }
    } else if let value = json as? NSNumber {
        result += value.intValue
    }

    return result
}

let data = FileHandle.standardInput().readDataToEndOfFile()

let json = try! JSONSerialization.jsonObject(with: data, options: [])

print(jsonObjectSum(json: json))
