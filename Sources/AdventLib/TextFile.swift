import Foundation

public class TextFile {

    private let fileHandle: NSFileHandle

    public class func standardInput() -> TextFile {
        return TextFile(fileHandle: NSFileHandle.fileHandleWithStandardInput())
    }

    private init(fileHandle: NSFileHandle) {
        self.fileHandle = fileHandle
    }

    public func readLines() -> AnySequence<String> {
        let inputData = fileHandle.readDataToEndOfFile()
        guard let inputString = String(data: inputData, encoding: NSUTF8StringEncoding) else {
            return AnySequence<String>([])
        }
        return AnySequence<String>(inputString.characters.split("\n").map { String ($0) })
    }

    public func readString() -> String {
        let inputData = fileHandle.readDataToEndOfFile()
        return String(data: inputData, encoding: NSUTF8StringEncoding) ?? ""
    }
}
