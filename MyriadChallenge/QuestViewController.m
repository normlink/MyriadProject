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

@interface QuestViewController ()
{
    
    __weak IBOutlet UITableView *myQuestTableView;
    Quest * banditsWoods;
    Quest * specialDelivery;
    Quest * filthyMongrel;
    NSMutableArray * questArray;
    NSMutableArray * tableviewArray;
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
        [self fillTableViewArray];
    }else {
        alignmentVar = [[NSUserDefaults standardUserDefaults] integerForKey:@"Alignment"];
        [self fillTableViewArray];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        banditsWoods = [[Quest alloc]init];
        specialDelivery = [[Quest alloc]init];
        filthyMongrel = [[Quest alloc]init];
        
        banditsWoods.questName = @"Bandits in the Woods";
        banditsWoods.alignment = @"GOOD";
        banditsWoods.description = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground. ";
        banditsWoods.location = @"(46.908588, -96.808991)";
        banditsWoods.questGiver = @"HotDogg The Bounty Hunter";
        banditsWoods.questGiverLocation = @"(46.8541979, -96.8285138)";
        banditsWoods.locationLatitude = @"46.908588";
        banditsWoods.locationLongitude = @"-96.808991";
        banditsWoods.questGiverLatitude = @"46.8541979";
        banditsWoods.questGiverLongitude = @"-96.8285138";
        
        specialDelivery.questName = @"Special Delivery";
        specialDelivery.alignment = @"NEUTRAL";
        specialDelivery.description = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
        specialDelivery.location = @"(46.8657639, -96.7363173)";
        specialDelivery.questGiver = @"Sir Jimmy The Swift";
        specialDelivery.questGiverLocation = @"(46.8739748, -96.806112)";
        specialDelivery.locationLatitude = @"46.8657639";
        specialDelivery.locationLongitude = @"-96.7363173";
        specialDelivery.questGiverLatitude = @"46.8739748";
        specialDelivery.questGiverLongitude = @"-96.806112";
        
        filthyMongrel.questName = @"Filthy Mongrel";
        filthyMongrel.alignment = @"EVIL";
        filthyMongrel.description = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
        filthyMongrel.location = @"(46.892386,-96.799669)";
        filthyMongrel.questGiver = @"Prince Jack, The Iron Horse";
        filthyMongrel.questGiverLocation = @"(46.8739748, -96.806112)";
        filthyMongrel.locationLatitude = @"46.892386";
        filthyMongrel.locationLongitude = @"-96.799669";
        filthyMongrel.questGiverLatitude = @"46.8739748";
        filthyMongrel.questGiverLongitude = @"-96.806112";
        
        questArray = [NSMutableArray arrayWithObjects:banditsWoods, specialDelivery, filthyMongrel, nil];
    }
    return self;
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
    
    for (Quest* quest in questArray) {
        if (alignmentVar == 0) {
            if ([quest.alignment isEqualToString:@"GOOD"]) {
                [tableviewArray addObject:quest];
            }}
        if (alignmentVar == 1) {
            [tableviewArray addObject:quest];
        }
        if (alignmentVar == 2) {
            if ([quest.alignment isEqualToString:@"EVIL"]) {
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
    
    cell.textLabel.text = [[tableviewArray objectAtIndex:indexPath.row] questName];
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
