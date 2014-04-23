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
    
    __weak IBOutlet UIBarButtonItem *acceptButton;
    __weak IBOutlet UILabel *questNameLabel;
    __weak IBOutlet UILabel *questAlignmentLabel;
    __weak IBOutlet UILabel *questLocationLabel;
    __weak IBOutlet UILabel *questGiverNameLabel;
    __weak IBOutlet UILabel *questGiverLocationLabel;
    __weak IBOutlet UILabel *questDescriptionLabel;
    __weak IBOutlet MKMapView *mapView;
    PFGeoPoint * locationGeoPoint;
    PFGeoPoint * questGiverGeoPoint;
}
- (IBAction)changeMapType:(id)sender;
- (IBAction)acceptQuest:(id)sender;

@end

@implementation DetailViewController

@synthesize detailInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self doParseQuery];
}

-(void) doParseQuery{
    PFQuery *query = [PFQuery queryWithClassName:@"Quests"];
    [query whereKey:@"name" equalTo:[detailInfo objectForKey:@"name"]];
    [query includeKey:@"questGiver"];
    [query includeKey:@"acceptedBy"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                questNameLabel.text = object[@"name"];
                [self getAlignmentString:object];
                locationGeoPoint = object[@"location"];
                questLocationLabel.text = [NSString stringWithFormat:@"(%f, %f)", locationGeoPoint.latitude,locationGeoPoint.longitude];
                questGiverNameLabel.text = [object objectForKey:@"questGiver"][@"name" ];
                questGiverGeoPoint = [object objectForKey:@"questGiver"][@"location" ];
                questGiverLocationLabel.text = [NSString stringWithFormat:@"(%f, %f)", questGiverGeoPoint.latitude,questGiverGeoPoint.longitude];
                questDescriptionLabel.text = object[@"description"];
                
                [self setMapview];
                
                if ([object objectForKey:@"acceptedBy"][@"username"]){
                    acceptButton.title = @"Complete";
                }
            }
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
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

-(void)setMapview
{
    MapAnnotations* questPin = [[MapAnnotations alloc] init];
    questPin.coordinate = CLLocationCoordinate2DMake(locationGeoPoint.latitude, locationGeoPoint.longitude);
    questPin.title = questNameLabel.text;
    
    MapAnnotations* giverPin = [[MapAnnotations alloc] init];
    giverPin.coordinate = CLLocationCoordinate2DMake(questGiverGeoPoint.latitude, questGiverGeoPoint.longitude);
    giverPin.title = questGiverNameLabel.text;
    
    NSArray* pinArray = [[NSArray alloc] initWithObjects:questPin,giverPin, nil];
    
    [mapView showAnnotations:pinArray animated:YES];
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

- (IBAction)acceptQuest:(id)sender
{
    if ([acceptButton.title  isEqual: @"Accept"]) {
        PFObject *accept = [PFObject objectWithClassName:@"Quests"];
        
        //The following line is not working; for sure left part is not properly accessing
        [accept objectForKey:@"acceptedBy"][@"username"] = [[PFUser currentUser] objectForKey:@"username"];
        [accept saveInBackground];
        acceptButton.title = @"Complete";
    } else if ([acceptButton.title  isEqual: @"Complete"]) {
        PFObject *complete = [PFObject objectWithClassName:@"Quests"];
        [complete setObject:[NSNumber numberWithBool:TRUE] forKey:@"completed"];
        [complete saveInBackground];
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
