//
//  CountryCodeController.m
//
// Copyright (c) 2014. All rights reserved.
//


#import "CountryListController.h"
#import "Utils.h"
#import "UserSessionInfo.h"

#define ROW_HEIGHT 45
#define SLIDE_TIMING .25
#define PANEL_WIDTH 20

@implementation CountryListController

@synthesize ccTable, strSelectedCountry;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];

	ccTable.rowHeight = ROW_HEIGHT;
    
    ccList = [[NSMutableArray alloc] init];
    ccIndexList = [[NSMutableArray alloc] init];
    countryIndexMap = [[NSMutableDictionary alloc] init];
    
    ccIndexList = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    ccList = @[];
    
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];    
    CountryListPresenter *presentor = userSession.dependencies.countryListPresenter;
    ccList = [presentor getCountryList];
    NSDictionary *countryDict = [presentor getCountryData];
    
    if (!countryDict || !ccList)
    {
        NSLog(@"Countries could not be loaded");
    }
    else
    {
        NSMutableArray *countryTemp = [[NSMutableArray alloc] init];
        for (NSString *sectionTitle in ccIndexList)
        {
            [countryTemp removeAllObjects];
            
            for (NSString *countryKey in ccList)
            {
                if([countryKey hasPrefix:sectionTitle])
                {
                    [countryTemp addObject:countryKey];
                }
            }
            
            NSArray *countries = [countryTemp copy];
            
            //Now we have a map between an alphabit index and list of countries
            
            [countryIndexMap setValue:countries forKey:sectionTitle];
        }
    }
    
    strSelectedCountry = [self getTrimmedString:strSelectedCountry];
        
}


- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    [ccTable reloadData];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height > 500)
        {
            //Hack to fix a UI bug
            
            [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,result.height)];
        }
    }
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //NO for iPhone
    return NO;
}



#pragma mark -
#pragma mark Private Methods

- (NSString *)getTrimmedString: (NSString *)inputString
{
    NSString* outputString = inputString;
    outputString = [outputString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return outputString;
}


#pragma mark -
#pragma mark Review Table Callbacks

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return ccIndexList;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [ccIndexList indexOfObject:title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ccIndexList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [ccIndexList objectAtIndex:section];
    
    NSArray *sectionCountries = [countryIndexMap objectForKey:sectionTitle];
    return [sectionCountries count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [ccIndexList objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        height = 70;
    }
    else
    {
        height = 40;
    }
    return height;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            cell.textLabel.font = [Utils getiPadAppFont];
        }
        else
        {
            cell.textLabel.font = [Utils getAppFont];
        }
    }
    
    // Configure the cell...
    NSString *sectionTitle = [ccIndexList objectAtIndex:indexPath.section];
    NSArray *sectionCountries = [countryIndexMap objectForKey:sectionTitle];
    NSString *countryWithCode = [sectionCountries objectAtIndex:indexPath.row];

    cell.textLabel.text = countryWithCode;
    
    if ([countryWithCode hasPrefix:strSelectedCountry])
    {
        // all the rows should show the disclosure indicator
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        // all the rows should show the disclosure indicator
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *currentCountry;
    
    // Configure the cell...
    NSString *sectionTitle = [ccIndexList objectAtIndex:indexPath.section];
    NSArray *sectionCountries = [countryIndexMap objectForKey:sectionTitle];
    currentCountry = [sectionCountries objectAtIndex:indexPath.row];

    [self.delegate selectCountry:currentCountry];
}





@end

