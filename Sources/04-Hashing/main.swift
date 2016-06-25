import Foundation
import SecurityFoundation

func md5(input: String) -> String {
    let inputData = (input as NSString).data(using: String.Encoding.utf8.rawValue)!

    let digester = SecDigestTransformCreate(kSecDigestMD5, 0, nil)

    SecTransformSetAttribute(digester, kSecTransformInputAttributeName, inputData, nil)

    let encodedData = SecTransformExecute(digester, nil) as! NSData

    var digestHex = ""
    for i in 0..<encodedData.length {
        digestHex += String(format: "%02x", UnsafePointer<UInt8>(encodedData.bytes)[i])
    }

    return digestHex
}

func mineRange(input: String, start: Int, endBefore: Int) -> (Int, String)? {
    print("\(start)")
    for i in start..<endBefore {
        let hashInput = "\(input)\(i)"
        let hash = md5(input: hashInput)
        if hash.hasPrefix("000000") {
            return (i, hash)
        }
    }
    return nil
}

func mine(input: String) -> (Int, String) {

    let queue = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault)
    var number = 0

    while true {
        print("number: \(number)")
        let group = DispatchGroup()

        for i in 0..<10 {
            group.notify(queue: queue, execute: { 
                if let result = mineRange(input: input, start: number + (i * 1000),
                                          endBefore: number + ((i + 1) * 1000)) {
                    print(result)
                    exit(0)
                }
            })
        }
        group.wait(timeout: DispatchTime.distantFuture)
        number += 10000
    }
}

if Process.arguments.count > 1 {
    print(mine(input: Process.arguments[1]))
} else {
    print(mine(input: "abcdef"))
}
