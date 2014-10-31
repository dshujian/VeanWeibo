//
//  DeckViewController.m
//  VeanWeibo
//
//  Created by 董书建 on 14/9/22.
//  Copyright (c) 2014年 Vean. All rights reserved.
//

#import "DeckViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DeckViewController ()

@property(nonatomic, strong) HomeViewController *centerController;
@property(nonatomic, strong) RightViewController *rightController;
@property(nonatomic, strong) LeftViewController *leftController;

@end

#define Num 260

@implementation DeckViewController

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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _centerController = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    _leftController = (LeftViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    _rightController = (RightViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];    
    
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_leftController.view];
    [_leftController.view setTag:2];
    [_leftController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_rightController.view];
    [_rightController.view setTag:3];
    [_rightController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
    
    //center 覆盖
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackFunc:) name: @"back" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideFunc:) name: @"hide" object:nil];

}
-(void) HideFunc:(NSNotification*) notification  {
    NSString *get = [notification object];
    if ([get isEqualToString:@"hide"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [_centerController.view setFrame:CGRectMake(320, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

-(void) BackFunc:(NSNotification*) notification  {
    NSString *get = [notification object];
    if ([get isEqualToString:@"back"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [_centerController.view setFrame:CGRectMake(0, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        [UIView commitAnimations];
    }
}

//手势的判断
-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
    CALayer *layer = [_centerController.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    
    //判断向右滑动
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView setAnimationDuration:0.35];
        [_leftController.view setHidden:NO];
        [_rightController.view setHidden:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == -Num) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+Num, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        [UIView commitAnimations];
    }
    //判断向左滑动
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [_rightController.view setHidden:NO];
        [_leftController.view setHidden:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == Num) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-Num, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        [UIView commitAnimations];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
