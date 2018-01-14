import Foundation

public class TextFile {

    private let fileHandle: FileHandle

    public class func standardInput() -> TextFile {
        return TextFile(fileHandle: FileHandle.standardInput)
    }

    private init(fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }

    public func readLines() -> AnySequence<String> {
        let inputData = fileHandle.readDataToEndOfFile()
        guard let inputString = String(data: inputData, encoding: String.Encoding.utf8) else {
            return AnySequence<String>([])
        }
        return AnySequence<String>(inputString.characters.split(separator: "\n").map { String($0) })
    }

    public func readString() -> String {
        let inputData = fileHandle.readDataToEndOfFile()
        return String(data: inputData, encoding: String.Encoding.utf8) ?? ""
    }
}
