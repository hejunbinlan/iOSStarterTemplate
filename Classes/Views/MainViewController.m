//
//  MainViewController.m
//
// Copyright (c) 2014. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "LeftPanelViewController.h"

#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2

#define CORNER_RADIUS 4

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60
#define IPAD_PANEL_WIDTH 500

@implementation MainViewController

@synthesize centerViewController;

#pragma mark -
#pragma mark View Did Load/Unload

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated
{
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


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
    else
    {
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
            //self.view = landscapeView;
            [self changeTheViewToPortrait:NO andDuration:duration];
        }
        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void) changeTheViewToPortrait:(BOOL)portrait andDuration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    //CGRect rectQuote;
    
    if(portrait)
    {
        //change the view and subview frames for the portrait view
        /*UIImage *img = [UIImage imageNamed:@"aum_360-Portrait.png"];
         [backgroungImage setImage:img];
         
         
         CGRect rectButton = CGRectMake((backgroungImage.bounds.origin.x - 50), (backgroungImage.bounds.origin.y + 180), backgroungImage.bounds.size.width, backgroungImage.bounds.size.height);
         [backgroungImage setFrame:rectButton];*/
        
        //rectQuote = CGRectMake((collectionView.bounds.origin.x), (collectionView.bounds.origin.y + 103),
        //                       (collectionView.bounds.size.width), collectionView.bounds.size.height);
    }
    else
    {
        //[self.view setFrame:[[UIScreen mainScreen] bounds]];
        
        //change the view and subview  frames for the landscape view
        /*UIImage *img = [UIImage imageNamed:@"aum_360-Landscape.png"];
         [backgroungImage setImage:img]; */
        
        //rectQuote = CGRectMake((collectionView.bounds.origin.x + 200), (collectionView.bounds.origin.y + 170),
        //                       (collectionView.bounds.size.width + 100), collectionView.bounds.size.height);
        
    }
    
    //[collectionView setFrame:rectQuote];
    
    [UIView commitAnimations];
}





#pragma mark -
#pragma mark Setup View

-(void)setupView {
    
   	NSLog(@"Debug Setting up MainViewController...");
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // nothing we are phone
        self.centerViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    }
    else
    {
        self.centerViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    }
    
	self.centerViewController.view.tag = CENTER_TAG;
	self.centerViewController.delegate = self;
	[self.view addSubview:self.centerViewController.view];
	[self addChildViewController:centerViewController];
	[centerViewController didMoveToParentViewController:self];
    
    self.centerViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    self.centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
    
   	NSLog(@"Debug Setting up Gestures...");
    
	[self setupGestures];
}

-(void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
	if (value) {
		[centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
		[centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
		[centerViewController.view.layer setShadowOpacity:0.8];
		[centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
	} else {
		[centerViewController.view.layer setCornerRadius:0.0f];
		[centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
	}
}

-(void)resetMainView {
	// remove left and right views, and reset variables, if needed
	if (_leftPanelViewController != nil) {
		[self.leftPanelViewController.view removeFromSuperview];
		self.leftPanelViewController = nil;
		centerViewController.leftSettingsButton.tag = 1;
		self.showingLeftPanel = NO;
	}
	// remove view shadows
	[self showCenterViewWithShadow:NO withOffset:0];
}

-(UIView *)getLeftView {
	// init view if it doesn't already exist
	if (_leftPanelViewController == nil)
	{
		// this is where you define the view for the left panel
		self.leftPanelViewController = [[LeftPanelViewController alloc] initWithNibName:@"LeftPanelViewController" bundle:nil];
		self.leftPanelViewController.view.tag = LEFT_PANEL_TAG;
		self.leftPanelViewController.delegate = centerViewController;
        
		[self.view addSubview:self.leftPanelViewController.view];
        
		[self addChildViewController:_leftPanelViewController];
		[_leftPanelViewController didMoveToParentViewController:self];
        
		_leftPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	}
    
	self.showingLeftPanel = YES;
    
	// setup view shadows
	[self showCenterViewWithShadow:YES withOffset:-2];
    
	UIView *view = self.leftPanelViewController.view;
	return view;
}

#pragma mark -
#pragma mark Swipe Gesture Setup/Actions

#pragma mark - setup

-(void)setupGestures {
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
	[panRecognizer setMinimumNumberOfTouches:1];
	[panRecognizer setMaximumNumberOfTouches:1];
	[panRecognizer setDelegate:self];
    
	[centerViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender {
	[[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            childView = [self getLeftView];
        }
        
        // make sure the view we're working with is front and center
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	}
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
	}
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        // are we more than halfway, if so, show the panel when done dragging by setting this value to YES (1)
        _showPanel = abs([sender view].center.x - centerViewController.view.frame.size.width/2) > centerViewController.view.frame.size.width/2;
        
        // allow dragging only in x coordinates by only updating the x coordinate with translation position
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        // if you needed to check for a change in direction, you could use this code to do so
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
	}
}

#pragma mark -
#pragma mark Delegate Actions

-(void)movePanelRight {
	UIView *childView = [self getLeftView];
	[self.view sendSubviewToBack:childView];
    
	[UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            centerViewController.view.frame = CGRectMake(self.view.frame.size.width - IPAD_PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        else
        {
            centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
	 }
	 completion:^(BOOL finished) {
		 if (finished) {
			 centerViewController.leftSettingsButton.tag = 0;
		 }
	 }];
}

-(void)movePanelToOriginalPosition
{
	[UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		 centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	 }
	 completion:^(BOOL finished) {
		 if (finished) {
			 [self resetMainView];
		 }
	 }];
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
