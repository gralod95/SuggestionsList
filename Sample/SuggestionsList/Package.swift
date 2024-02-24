// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuggestionsList",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SuggestionsList",
            targets: ["SuggestionsList"]
	),
    ],
    targets: [
        .target(
            name: "SuggestionsList"
	),
        .testTarget(
            name: "SuggestionsListTests",
            dependencies: ["SuggestionsList"]
	),
    ]
)
