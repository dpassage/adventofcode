import Foundation
import SecurityFoundation

func md5(input: String) -> String {
    let inputData = (input as NSString).dataUsingEncoding(NSUTF8StringEncoding)!

    let digester = SecDigestTransformCreate(kSecDigestMD5, 0, nil)

    SecTransformSetAttribute(digester, kSecTransformInputAttributeName, inputData, nil)

    let encodedData = SecTransformExecute(digester, nil) as! NSData

    var digestHex = ""
    for i in 0..<encodedData.length {
        digestHex += String(format: "%02x",UnsafePointer<UInt8>(encodedData.bytes)[i])
    }

    return digestHex
}

func mineRange(input: String, start: Int, endBefore: Int) -> (Int, String)? {
    print("\(start)")
    for i in start..<endBefore {
        let hashInput = "\(input)\(i)"
        let hash = md5(hashInput)
        if hash.hasPrefix("000000") {
            return (i, hash)
        }
    }
    return nil
}

func mine(input: String) -> (Int, String) {

    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    var number = 0

    while true {
        print("number: \(number)")
        let group = dispatch_group_create()

        for i in 0..<10 {
            dispatch_group_async(group, queue, {
                if let result = mineRange(input, start: number + (i * 1000), endBefore: number + ((i + 1) * 1000)) {
                    print(result)
                    exit(0)
                }
            })
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        number += 10000
    }
}

if Process.arguments.count > 1 {
        print(mine(Process.arguments[1]))
} else {
        print(mine("abcdef"))
}
