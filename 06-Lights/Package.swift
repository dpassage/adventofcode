import PackageDescription

let package = Package(
    name: "Lights",
    dependencies: [
        .Package(url: "../AdventLib", majorVersion: 1)
    ]
)
