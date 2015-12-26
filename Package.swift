import PackageDescription

let package = Package(
    targets: [
        Target(
            name: "01-Floors",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "02-Presents",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "03-Visits",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "05-Nice",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "06-Lights",
            dependencies: [.Target(name: "AdventLib")]),
        Target(
            name: "AdventLib")
    ]
)
