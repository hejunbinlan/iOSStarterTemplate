
//
//
// Copyright (c) 2014. All rights reserved.
//


#import "HomeViewController.h"
#import "vipertestAppDelegate.h"
#import "UserSessionInfo.h"
#import "Utils.h"
#import "Author.h"

@implementation HomeViewController

@synthesize adBannerView, authPresenter;

#pragma mark - UIView Management Functions

// Set things up on load
- (void)viewDidLoad {
    
    [self.adBannerView setDelegate:self];
	NSLog(@"Debug entering viewDidLoad");

    CGSize result = [[UIScreen mainScreen] bounds].size;
    viewHeight = result.height;
    
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    AuthorPresenter *presentor = userSession.dependencies.authorPresenter;
    
    authPresenter = presentor;
    authPresenter.delegate = self;

    // Load huddles
    [self f_load];
    
    NSLog(@"Debug f_load is complete");
    
	[super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{ 
    [super viewWillAppear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //Our ensure we show the proper image on load based on orientation
        NSTimeInterval duration = 0.0;
        if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeTheViewToPortrait:YES andDuration:duration];
        }
        else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            //self.view = landscapeView;
            [self changeTheViewToPortrait:NO andDuration:duration];
        }
    }
    else
    {
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //YES for iPad
        return YES;
    }
    else
    {
        //NO for iPhone
        return NO;
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeTheViewToPortrait:YES andDuration:duration];
        }
        else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            [self changeTheViewToPortrait:NO andDuration:duration];
        }
        
        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
    }
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)dealloc
{
    
}


#pragma mark - IBButton Handlers

// Go MovePanelRight
- (IBAction)MovePanelRight:(id)sender {
    NSLog(@"MovePanelRight..");
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            NSLog(@"Moving Original Pos..");
            [_delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            NSLog(@"Moving Right Pos..");            
            [_delegate movePanelRight];
            break;
        }
            
        default:
            break;
    }
}

- (IBAction)RefreshData:(id)sender {
    [activityIndicator startAnimating];
    [activityIndicator setHidden:NO];
    [refresh setHidden:YES];
    [self.authPresenter getAllAuthors];
}

#pragma mark - Private Methods

- (void) changeTheViewToPortrait:(BOOL)portrait andDuration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    if(portrait)
    {
        UIImage *img = [UIImage imageNamed:@"bgback.jpg"];
        [imageBackground setImage:img];
        [imageBackground setContentMode:UIViewContentModeScaleAspectFill];
    }
    else
    {
        UIImage *img = [UIImage imageNamed:@"bgbackLandscape.jpg"];
        [imageBackground setImage:img];
        [imageBackground setContentMode:UIViewContentModeScaleAspectFill];
    }
    
    [UIView commitAnimations];
}


- (void)f_load {
    
    NSLog(@"Debug running f_load");
    [activityIndicator startAnimating];
    [activityIndicator setHidden:NO];
    [refresh setHidden:YES];
    
    [self.authPresenter getAllAuthors];
    
    NSLog(@"Debug out of f_load");
}

- (void) fixViewHeightIssue
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
    }
    else
    {
        if (viewHeight > 500)
        {
            //Hack to fix a UI bug
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,result.height)];
        }
    }
}

#pragma mark - LeftPanelViewControllerDelegate

- (void)settingItemSelected:(long)selOption
{
   [_delegate movePanelToOriginalPosition];
}

#pragma mark -
#pragma mark AuthorDetails Delegate Event Handler

- (void)hideAuthorDetails
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self fixViewHeightIssue];
}

#pragma mark - Author Presentor Output

-(void)getAllAuthorsSuccess: (id) authorData
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    [refresh setHidden:NO];
    NSMutableArray *authorDetails = (NSMutableArray *)authorData;
    authorList = authorDetails;
    
    //Reload view
    [authorTableView reloadData];
    
    NSLog(@"Getting Author Data is a success!!!!");
}

-(void)getAllAuthorsFailed: (NSString *)error
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    [refresh setHidden:NO];
    NSLog(@"Getting Author Data is a success!!!!");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error getting Author data. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - iAD Delegate

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 40;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:1];
    
    [UIView commitAnimations];
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:0];
    
    [UIView commitAnimations];
}



#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [authorList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 80;
    }
    else
    {
        return 60;
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
   return @"Functions";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NavItemCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NavItemCell"];
        cell.frame = CGRectMake(0.0, 0.0, 420.0, 60);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            cell.textLabel.font = [Utils getiPadAppFont];
        }
        else
        {
            cell.textLabel.font = [Utils getAppFont];
        }
    }
    
    // Set up the cell...
    NSUInteger row = [indexPath row];
    
    if ([authorList count] > 0)
    {
        Author *author = nil;
        
        author = [authorList objectAtIndex:row];
        cell.textLabel.text = author.title;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (authorDetailsController == nil)
    {
        AuthorDetailsViewController *qNaParticipationVC = [[AuthorDetailsViewController alloc] initWithNibName:@"AuthorDetailsController" bundle:nil];
        authorDetailsController = qNaParticipationVC;
        authorDetailsController.delegate = self;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //Create a Navigation controller
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:authorDetailsController];
        
        navController.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        //Show the navigation controller modally
        [self presentViewController:navController animated:YES completion:^(void) {}];
    }
    else
    {
        authorDetailsController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:authorDetailsController animated:YES completion:^(void) {}];
    }
}



@end
