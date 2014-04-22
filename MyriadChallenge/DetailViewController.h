//
//  DetailViewController.h
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/16/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quest.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PFObject * detailInfo;

@end
