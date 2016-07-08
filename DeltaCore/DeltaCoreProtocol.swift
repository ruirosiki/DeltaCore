//
//  DeltaCoreProtocol.swift
//  DeltaCore
//
//  Created by Riley Testut on 6/29/16.
//  Copyright © 2016 Riley Testut. All rights reserved.
//

import Foundation

public protocol DeltaCoreProtocol: CustomStringConvertible
{
    var bundleIdentifier: String { get }
    
    var supportedGameTypes: Set<GameType> { get }
    
    var emulatorBridge: EmulatorBridging { get }
    
    var emulatorConfiguration: EmulatorConfiguration { get }
    
    var inputTransformer: InputTransforming { get }
}

extension DeltaCoreProtocol
{
    public var description: String {
        return self.bundleIdentifier
    }
}
