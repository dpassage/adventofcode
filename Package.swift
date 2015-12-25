import PackageDescription

let package = Package(
    targets: [
        Target(
            name: "01-Floors",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "06-Lights",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "AdventLib")
    ]
)
