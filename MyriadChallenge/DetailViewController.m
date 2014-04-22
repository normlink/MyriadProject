//
//  DetailViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/16/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "DetailViewController.h"
#import "MapAnnotations.h"

@interface DetailViewController (){
    
    __weak IBOutlet UILabel *questNameLabel;
    __weak IBOutlet UILabel *questAlignmentLabel;
    __weak IBOutlet UILabel *questLocationLabel;
    __weak IBOutlet UILabel *questGiverNameLabel;
    __weak IBOutlet UILabel *questGiverLocationLabel;
    __weak IBOutlet UILabel *questDescriptionLabel;
    __weak IBOutlet MKMapView *mapView;
    PFGeoPoint * locationGeoPoint;

}
- (IBAction)changeMapType:(id)sender;

@end

@implementation DetailViewController

@synthesize detailInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doParseQuery];
    
//    questNameLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questName];
//    questAlignmentLabel.text = [NSString stringWithFormat:@"%@", detailInfo.alignment];
//    questLocationLabel.text = [NSString stringWithFormat:@"%@", detailInfo.location];
//    questGiverNameLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questGiver];
//    questGiverLocationLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questGiverLocation];
//    questDescriptionLabel.text = [NSString stringWithFormat:@"%@", detailInfo.description];
//    
//    float questLatitude = detailInfo.locationLatitude.floatValue;
//    float questLongitude = detailInfo.locationLongitude.floatValue;
//    float giverLatitude = detailInfo.questGiverLatitude.floatValue;
//    float giverLongitude = detailInfo.questGiverLongitude.floatValue;
//    
//    MapAnnotations* questPin = [[MapAnnotations alloc] init];
//    questPin.coordinate = CLLocationCoordinate2DMake(questLatitude, questLongitude);
//    questPin.title = questNameLabel.text;
//    
//    MapAnnotations* giverPin = [[MapAnnotations alloc] init];
//    giverPin.coordinate = CLLocationCoordinate2DMake(giverLatitude, giverLongitude);
//    giverPin.title = questGiverNameLabel.text;
//    
//    NSArray* pinArray = [[NSArray alloc] initWithObjects:questPin,giverPin, nil];
//    
//    [mapView showAnnotations:pinArray animated:YES];
}

-(void) doParseQuery{
    PFQuery *query = [PFQuery queryWithClassName:@"Quests"];
    [query whereKey:@"name" equalTo:[detailInfo objectForKey:@"name"]];
//    [query includeKey:@"questGiver"];
//    [query whereKey:@"questGiver" equalTo:User];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
              
                questNameLabel.text = object[@"name"];
                [self getAlignmentString:object];
                locationGeoPoint = object[@"location"];
                questLocationLabel.text = [NSString stringWithFormat:@"(%f, %f)", locationGeoPoint.latitude,locationGeoPoint.longitude];
//                questGiverNameLabel.text = object[@"questGiver.name"];
                questGiverNameLabel.text = object[@"questgiver.name"];
//                    questGiverLocationLabel.text = [NSString stringWithFormat:@"(%f, %f)", questGiverGeoPoint.latitude,questGiverGeoPoint.longitude];
                    questDescriptionLabel.text = object[@"description"];
            }
 
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
         NSLog(@"geopoint %@",locationGeoPoint);
    }];
    
   
}
-(void)getAlignmentString:(PFObject*)object
{
    

            if ([object[@"alignment"] isEqual:@0]) {
                questAlignmentLabel.text = @"GOOD";
            }
    if ([object[@"alignment"] isEqual:@1]) {
        questAlignmentLabel.text = @"NEUTRAL";
    }
    if ([object[@"alignment"] isEqual:@2]) {
        questAlignmentLabel.text = @"EVIL";
    }
    
}

- (IBAction)changeMapType:(id)sender
{
    switch (((UISegmentedControl *) sender).selectedSegmentIndex){
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
