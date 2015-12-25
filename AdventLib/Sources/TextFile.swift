import Foundation

class TextFile {

    private let fileHandle: NSFileHandle

    class func standardInput() -> TextFile {
        return TextFile(fileHandle: NSFileHandle.fileHandleWithStandardInput())
    }

    private init(fileHandle: NSFileHandle) {
        self.fileHandle = fileHandle
    }

    func readLines() -> [String] {
        let inputData = fileHandle.readDataToEndOfFile()
        guard let inputString = String(data: inputData, encoding: NSUTF8StringEncoding) else {
            return []
        }
        return inputString.characters.split("\n").map { String ($0) }
    }
}
