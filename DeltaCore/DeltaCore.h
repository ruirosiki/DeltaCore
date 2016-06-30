//
//  DeltaCore.h
//  DeltaCore
//
//  Created by Riley Testut on 3/8/15.
//  Copyright (c) 2015 Riley Testut. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for DeltaCore.
FOUNDATION_EXPORT double DeltaCoreVersionNumber;

//! Project version string for DeltaCore.
FOUNDATION_EXPORT const unsigned char DeltaCoreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DeltaCore/PublicHeader.h>
#import <DeltaCore/DynamicObject.h>

#import <DeltaCore/NSThread+RealTime.h>

// C-Libraries
#import <DeltaCore/TPCircularBuffer.h>

// HACK: Needed because the generated DeltaCore-Swift header file doesn't include this import
#import <GLKit/GLKit.h>

// Game Identifiers
typedef NSString *GameType NS_EXTENSIBLE_STRING_ENUM;
