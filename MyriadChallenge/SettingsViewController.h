//
//  SettingsViewController.h
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/18/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DetailViewController.h"
//#import "Quest.h"

@protocol SettingsDelegate;

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id <SettingsDelegate> settingsDelegate;

@end

@protocol SettingsDelegate <NSObject>

-(void)getAlignmentVar:(int)integer;

@end