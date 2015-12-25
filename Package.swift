import PackageDescription

let package = Package(
    targets: [
        Target(
            name: "06-Lights",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "AdventLib")
    ]
)
