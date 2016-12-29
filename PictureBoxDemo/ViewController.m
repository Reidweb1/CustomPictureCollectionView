//
//  ViewController.m
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import "ViewController.h"

#define ARC4RANDOM_MAX 0x100000000

#define BAR_HEIGHT 25
#define BOX_SIZE   30
#define BAR_WIDTH  100
#define BUFFER     8

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) NSMutableArray *boxArray;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIView *barView;
@property (strong, nonatomic) UIView *ballView;

@end

@implementation ViewController {
    BOOL yDirection;
    BOOL xDirection;
    CGFloat xMove;
    CGFloat yMove;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    yDirection = true;
    xDirection = true;
    xMove = -1;
    yMove = -1;
    
    self.playButton.hidden = true;
    self.boxArray = [[NSMutableArray alloc] init];
    [self createBoxes];
    [self getBarView];
    [self createMovingView];
    self.timer =  [NSTimer timerWithTimeInterval:0.01
                                          target:self
                                        selector:@selector(timerFired:)
                                        userInfo:nil
                                         repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createBoxes
{
    CGFloat xIndex   = BUFFER;
    CGFloat yIndex   = 68;
    CGFloat tagIndex = 0;
    
    for (int i = 0; i <= 5; i++) {
        for (int j = 0; j <= 10; j++) {
            
            if (xIndex >= self.view.frame.size.width - (BUFFER + BOX_SIZE))
                break;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xIndex, yIndex, BOX_SIZE, BOX_SIZE)];
            [view setBackgroundColor:[self getRandomColor]];
            view.tag = tagIndex;
            tagIndex++;
            
            view.userInteractionEnabled = true;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(boxTapped:)];
            [view addGestureRecognizer:tap];
            [self.boxArray addObject:view];
            
            [self.view addSubview:view];
            xIndex += (BUFFER + BOX_SIZE);
        }
        
        yIndex += (BUFFER + BOX_SIZE);
        xIndex = BUFFER;
    }
}

- (void)boxTapped:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        sender.view.hidden = true;
    }];
}

- (void)getBarView
{
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BAR_WIDTH/2, self.view.frame.size.height - (BAR_HEIGHT * 2), BAR_WIDTH, BAR_HEIGHT)];
    [self.barView setBackgroundColor:[UIColor blackColor]];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGesture:)];
    [self.barView addGestureRecognizer:pan];
    [self.view addSubview:self.barView];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    CGRect rect = self.barView.frame;
    CGPoint point = [gesture locationInView:self.view];
    CGFloat xPoint = MAX(point.x - (BAR_WIDTH/2), BUFFER);
    
    if (xPoint > self.view.frame.size.width - BAR_WIDTH - BUFFER)
        xPoint = self.view.frame.size.width - BAR_WIDTH - BUFFER;
    
    self.barView.frame = CGRectMake(xPoint, rect.origin.y, rect.size.width, rect.size.height);
}

- (UIColor *)getRandomColor
{
    CGFloat red   = ((CGFloat)arc4random() / ARC4RANDOM_MAX);
    CGFloat green = ((CGFloat)arc4random() / ARC4RANDOM_MAX);
    CGFloat blue  = ((CGFloat)arc4random() / ARC4RANDOM_MAX);
    
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:1.0];
}

- (void)createMovingView
{
    self.ballView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BOX_SIZE/2, self.barView.frame.origin.y - BOX_SIZE - BUFFER, BOX_SIZE, BOX_SIZE)];
    
    [self.ballView setBackgroundColor:[UIColor blackColor]];
    [self.ballView layer].cornerRadius = 10;
    
    [self.view addSubview:self.ballView];
}

- (void)timerFired:(NSTimer *)timer
{
    [self resetBallFrame];
    [self checkForCollision];
}

- (void)resetBallFrame
{
    CGRect rect = self.ballView.frame;
    
    if (!yDirection) {
        yMove = (yMove * yMove);
    }
    
    if (!xDirection) {
        xMove = (xMove * xMove);
    }
    
    self.ballView.frame = CGRectMake(rect.origin.x, rect.origin.y + yMove, rect.size.width, rect.size.height);
}

- (void)checkForCollision
{
    for (UIView *view in self.boxArray) {
        if (CGRectIntersectsRect(self.ballView.frame, view.frame)) {
            view.hidden = true;
        }
    }
}

@end
