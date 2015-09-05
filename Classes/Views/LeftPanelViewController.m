//
//  LeftViewController.m
//
// Copyright (c) 2014. All rights reserved.
//


#import "LeftPanelViewController.h"
#import "WSService.h"
#import "LeftNavCell.h"

#define ROW_HEIGHT 50

@interface LeftPanelViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfSettings;
@property (nonatomic, strong) NSMutableArray *arrayOfImagesForSettings;
@property (nonatomic, strong) NSMutableArray *arrayOfAppFunctions;
@property (nonatomic, strong) NSMutableArray *arrayOfImagesForFunctions;

@end

@implementation LeftPanelViewController

@synthesize leftNavTableView;

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [leftNavTableView registerClass:[LeftNavCell
                                         class]forCellReuseIdentifier:@"LeftNavRCell"];
    
    [leftNavTableView registerNib:[UINib nibWithNibName:@"LeftNavCell" bundle:nil] forCellReuseIdentifier:@"LeftNavRCell"];
    
    /*self.myTableView.sectionHeaderHeight = 0.0;
    self.myTableView.sectionFooterHeight = 0.0;*/
    
    [self setupSettingsArray];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [leftNavTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Array Setup

- (void)setupSettingsArray
{
    NSString *string = @"";
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[string stringByAppendingString:@"Home"]];
    [items addObject:[string stringByAppendingString:@"My Notifications"]];
    [items addObject:[string stringByAppendingString:@"Manage Contacts"]];
    [items addObject:[string stringByAppendingString:@"Change PhoneNumber"]];
    [items addObject:[string stringByAppendingString:@"Invite to viperTest"]];

    NSMutableArray *itemsSettings = [[NSMutableArray alloc] init];
    [itemsSettings addObject:[string stringByAppendingString:@"About This App"]];
    [itemsSettings addObject:[string stringByAppendingString:@"Take a Tour"]];
    [itemsSettings addObject:[string stringByAppendingString:@"Terms of Use"]];
    [itemsSettings addObject:[string stringByAppendingString:@"Privacy Policy"]];
    [itemsSettings addObject:[string stringByAppendingString:@"Rate us"]];

    string = @"";
    NSMutableArray *itemsImages = [[NSMutableArray alloc] init];
    [itemsImages addObject:[string stringByAppendingString:@"AppIcon180x180@3x.png"]];
    [itemsImages addObject:[string stringByAppendingString:@"optMyNotif.png"]];
    [itemsImages addObject:[string stringByAppendingString:@"optMyContacts.png"]];
    [itemsImages addObject:[string stringByAppendingString:@"optChangeNumber.png"]];
    [itemsImages addObject:[string stringByAppendingString:@"optInvite.png"]];
    
    NSMutableArray *itemsSettingsImages = [[NSMutableArray alloc] init];
    [itemsSettingsImages addObject:[string stringByAppendingString:@"optAbout.png"]];
    [itemsSettingsImages addObject:[string stringByAppendingString:@"optTour.png"]];
    [itemsSettingsImages addObject:[string stringByAppendingString:@"optTerms.png"]];
    [itemsSettingsImages addObject:[string stringByAppendingString:@"optPrivacy.png"]];
    [itemsSettingsImages addObject:[string stringByAppendingString:@"optRateUs.png"]];

    
    self.arrayOfImagesForSettings = itemsSettingsImages;
    self.arrayOfImagesForFunctions = itemsImages;
    self.arrayOfSettings = itemsSettings;
    self.arrayOfAppFunctions = items;
    
    [leftNavTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [self.arrayOfAppFunctions count];
    else
        return [self.arrayOfSettings count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 55;
    }
    else
    {
        return 46;
    }
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Functions";
    else
        return @"Support";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftNavCell *cell = (LeftNavCell *) [tableView dequeueReusableCellWithIdentifier:@"LeftNavRCell"];
    cell.frame = CGRectMake(0.0, 0.0, 320.0, 72);
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // Set up the cell...
	NSUInteger row = [indexPath row];
	
    if(indexPath.section == 0)
    {
        if ([self.arrayOfAppFunctions count] > 0)
        {
            NSString *item = nil;
            item = [self.arrayOfAppFunctions objectAtIndex:row];
            
            NSString *itemImage = nil;
            itemImage = [self.arrayOfImagesForFunctions objectAtIndex:row];
            
            cell.menuItemName = item;
            cell.imageName = itemImage;
        }
    }
    else
    {
        if ([self.arrayOfSettings count] > 0)
        {
            NSString *item = nil;
            item = [self.arrayOfSettings objectAtIndex:row];
            
            NSString *itemImage = nil;
            itemImage = [self.arrayOfImagesForSettings objectAtIndex:row];
            
            cell.menuItemName = item;
            cell.imageName = itemImage;
        }
    }
    
    [cell render];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate settingItemSelected:indexPath.row];
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
