//
//  SettingsViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/18/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController (){
    
    __weak IBOutlet UISegmentedControl *segmentController;
    int selectedSegment;
    
}
- (IBAction)alignmentSelection:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Alignment"] != 1) {
        segmentController.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"Alignment"];
    }
}

- (IBAction)alignmentSelection:(id)sender {
    
    if (segmentController.selectedSegmentIndex == 0) {
        [self.settingsDelegate getAlignmentVar:0];
    }
    if (segmentController.selectedSegmentIndex == 1) {
        [self.settingsDelegate getAlignmentVar:1];
    }
    if (segmentController.selectedSegmentIndex == 2) {
        [self.settingsDelegate getAlignmentVar:2];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:segmentController.selectedSegmentIndex forKey:@"Alignment"];
    [[NSUserDefaults standardUserDefaults] synchronize]; //need this to work with simulator
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
