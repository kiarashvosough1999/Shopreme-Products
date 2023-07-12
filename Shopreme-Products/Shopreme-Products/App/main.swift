//
//  main.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/12/23.
//

import Foundation
import UIKit

let argc = CommandLine.argc
let argv = CommandLine.unsafeArgv


/// Avoids calls for AppDelegate in UnitTest.
private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

_ = UIApplicationMain(argc, argv, nil, delegateClassName())

