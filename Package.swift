// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftFFmpeg",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "SwiftFFmpeg",
      targets: ["SwiftFFmpeg"]
    )
  ],
  targets: [
    .systemLibrary(
      name: "CFFmpeg",
      pkgConfig: "libavformat"
    ),
    .target(
      name: "SwiftFFmpeg",
      dependencies: ["CFFmpeg"]
    ),
    .target(
      name: "SwiftFFmpegExamples",
      dependencies: ["SwiftFFmpeg"]
    )
  ]
)


//let package = Package(
//  name: "SwiftFFmpeg",
//  products: [
//    .library(
//      name: "SwiftFFmpeg",
//      targets: ["SwiftFFmpeg", "CFFmpeg"]
//    )
//  ],
//  targets: [
//    .target(
//        name: "CFFmpeg",
//        path: "Sources/CFFmpeg",
//        sources: ["AVUtil_shim.h", "AVFormat_shim.h", "AVCodec_shim.h", "AVFilter_shim.h", "Swscale_shim.h", "Swresample_shim.h"],
//        publicHeadersPath: "include"
//    ),
//    .target(
//        name: "SwiftFFmpeg",
//        dependencies: ["CFFmpeg"],
//        path: "Sources/SwiftFFmpeg"
//        
//    )
//  ]
//)
