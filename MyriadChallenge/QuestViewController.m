//
//  QuestViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/16/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "QuestViewController.h"
#import "Quest.h"
#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface QuestViewController ()
{
    
    __weak IBOutlet UITableView *myQuestTableView;
    Quest * banditsWoods;
    Quest * specialDelivery;
    Quest * filthyMongrel;
    NSMutableArray * questArray;
    NSMutableArray * tableviewArray;
    NSMutableArray * testArray;
    int tableRow;
    int alignmentVar;
}
- (IBAction)getSettings:(id)sender;

@end

@implementation QuestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"Alignment"]) {
        alignmentVar = 1;
    }else {
        alignmentVar = [[NSUserDefaults standardUserDefaults] integerForKey:@"Alignment"];
    }
    
    [self doParseQuery];
}

-(void) doParseQuery{
    PFQuery *query = [PFQuery queryWithClassName:@"Quests"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            questArray = [[NSMutableArray alloc] initWithArray:objects];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        
//        for (PFObject *object in questArray) {
//            NSLog(@"%@",[object objectForKey:@"name"]);
//        }
        [self fillTableViewArray];
    }];
}

#pragma mark SettingsDelegate
-(void)getAlignmentVar:(int)integer
{
    alignmentVar = integer;
    [self fillTableViewArray];
    
}

-(void)fillTableViewArray
{
    tableviewArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (PFObject* quest in questArray) {
        if (alignmentVar == 0) {
            if ([quest[@"alignment"] isEqual:@0]) {
                [tableviewArray addObject:quest];
            }}
        if (alignmentVar == 1) {
            [tableviewArray addObject:quest];
        }
        if (alignmentVar == 2) {
            if ([quest[@"alignment"] isEqual:@2]) {
                [tableviewArray addObject:quest];
            }}
    }
    [myQuestTableView reloadData];
    
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableviewArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"my identifier"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"my identifier"];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    PFObject* cellObject = [tableviewArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [cellObject objectForKey:@"name"];
    
    return cell;
}

-  (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableRow = indexPath.row;
    [self performSegueWithIdentifier:@"toDetailVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toDetailVC"])
    {
        DetailViewController * detailVC = segue.destinationViewController;
        detailVC.detailInfo = [tableviewArray objectAtIndex:tableRow];
    }
    if ([[segue identifier] isEqualToString:@"toSettingsVC"])
    {
        SettingsViewController * settingsVC = segue.destinationViewController;
        settingsVC.settingsDelegate = self;
    }
}

- (IBAction)getSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettingsVC" sender:self];
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
