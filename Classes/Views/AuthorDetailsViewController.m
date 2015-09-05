
//
//
// Copyright (c) 2014. All rights reserved.
//

#import "AuthorDetailsViewController.h"
#import "UserSessionInfo.h"
#import "Utils.h"

#import "Author.h"

@implementation AuthorDetailsViewController


#pragma mark - UIView Management Functions

// Set things up on load
- (void)viewDidLoad {
    
	NSLog(@"Debug entering viewDidLoad");

    CGSize result = [[UIScreen mainScreen] bounds].size;
    viewHeight = result.height;
    
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    AuthorPresenter *presentor = userSession.dependencies.authorPresenter;
    
    authPresenter = presentor;
    authPresenter.delegate = self;

	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSLog(@"Loading data...");
    // Load
    [self f_load];
    
    NSLog(@"Debug f_load is complete");
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
    [self fixViewHeightIssue];
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
    //NO for iPhone
    return NO;
}


- (void)dealloc
{
    
}

#pragma mark - Button handlers


- (IBAction) closeThis : (id)sender
{
    if (changesMade)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Changes Made" message:@"You entered some huddle information. Are you sure you want to discard the changes?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        alert.tag = 7;
        
        [alert show];
    }
    else
    {
        changesMade = NO;
    
        /*txtQuestion.text = @"";
        btnImageThumbnail.imageView.image = [UIImage imageNamed:@"addpic.png"];
        [self setPickedImage:nil];
        addPhotoImg = TRUE;
    
        fAllowParticipantsToInviteOthers = NO;
        fAllowParticipantsToComment = YES;
        fAllowParticipantsToShare = NO;

        [contactList removeAllObjects];
        
        NSString *strTemp = [[NSString alloc]init];
        strTemp = [strTemp stringByAppendingFormat:@"Tap to Add Participants (%ld Selected)", contactList.count];
        selectContactsMessage.text = strTemp;
    
        [self closeOptionView:nil];
        [txtQuestion resignFirstResponder];
        
        [activityIndicator setHidden:YES];
        [activityIndicator stopAnimating];
        
        [btnSend setHidden:NO];*/
        
        [self.delegate hideAuthorDetails];
    }
}

//Delegate fired when adding a pet
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 7)
    {
        switch(buttonIndex) {
            case 0: //"Yes" pressed
            {
                changesMade = NO;
                
                /*txtQuestion.text = @"";
                btnImageThumbnail.imageView.image = [UIImage imageNamed:@"addpic.png"];
                [self setPickedImage:nil];
                addPhotoImg = TRUE;
                
                fAllowParticipantsToInviteOthers = NO;
                fAllowParticipantsToComment = YES;
                fAllowParticipantsToShare = NO;
                
                [contactList removeAllObjects];
                
                NSString *strTemp = [[NSString alloc]init];
                strTemp = [strTemp stringByAppendingFormat:@"Tap to Add Participants (%ld Selected)", contactList.count];
                selectContactsMessage.text = strTemp;
                
                [self closeOptionView:nil];
                [txtQuestion resignFirstResponder];
                
                [activityIndicator setHidden:YES];
                [activityIndicator stopAnimating];
                
                [btnSend setHidden:NO];  */
                
                [self.delegate hideAuthorDetails];
                break;
            }
            case 1: //"No" pressed
            {
                break;
            }
        }
    }
}

- (IBAction) saveHuddle : (id)sender
{

}



#pragma mark - Private Methods

//
//
- (void)f_load {
    
    NSLog(@"Debug running f_load");
    
    [activityIndicator startAnimating];
    [activityIndicator setHidden:NO];
    
    [authPresenter getAuthorDetailsGiven:@"5"];
    
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



#pragma mark - Author Presentor Output

-(void)getAuthorDetailsSuccess: (id) authorData
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    Author *authorDetails = (Author *)authorData;
    dummyData.text = authorDetails.body;
    
    NSLog(@"Getting Author Data is a success!!!!");
}

-(void)getAuthorDetailsFailed: (NSString *)error
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    NSLog(@"Getting Author Data is a failure!!!!");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error getting Author data. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}




@end
