//
//  Quest.h
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/16/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quest : NSObject

@property (strong, nonatomic) NSString *questName;
@property (strong, nonatomic) NSString *alignment;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *questGiver;
@property (strong, nonatomic) NSString *questGiverLocation;

@end
