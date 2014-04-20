//
//  MapAnnotations.h
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/19/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotations : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
