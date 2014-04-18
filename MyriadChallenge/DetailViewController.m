//
//  DetailViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/16/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    
    __weak IBOutlet UILabel *questNameLabel;
    __weak IBOutlet UILabel *questAlignmentLabel;
    __weak IBOutlet UILabel *questLocationLabel;
    __weak IBOutlet UILabel *questGiverNameLabel;
    __weak IBOutlet UILabel *questGiverLocationLabel;
    __weak IBOutlet UILabel *questDescriptionLabel;
    
}

@end

@implementation DetailViewController

@synthesize detailInfo;

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
    questNameLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questName];
    questAlignmentLabel.text = [NSString stringWithFormat:@"%@", detailInfo.alignment];
    questLocationLabel.text = [NSString stringWithFormat:@"%@", detailInfo.location];
    questGiverNameLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questGiver];
    questGiverLocationLabel.text = [NSString stringWithFormat:@"%@", detailInfo.questGiverLocation];
    questDescriptionLabel.text = [NSString stringWithFormat:@"%@", detailInfo.description];
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
