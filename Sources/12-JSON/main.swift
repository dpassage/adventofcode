import Foundation

func jsonObjectSum(json: AnyObject) -> Int {
    var result = 0

    if let dict = json as? Dictionary<String, AnyObject> {
        for value in dict.values {
            if let word = value as? String where
                word == "red" {
                    return 0
                }
            result += jsonObjectSum(value)
        }
    } else if let arr = json as? Array<AnyObject> {
        for value in arr {
            result += jsonObjectSum(value)
        }
    } else if let value = json as? NSNumber {
        result += value.integerValue
    }

    return result
}

let data = NSFileHandle.fileHandleWithStandardInput().readDataToEndOfFile()

let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])

print(jsonObjectSum(json))
