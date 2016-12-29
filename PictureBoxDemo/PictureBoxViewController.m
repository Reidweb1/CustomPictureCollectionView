//
//  PictureBoxViewController.m
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import "PictureBoxViewController.h"
#import "SPPictureScrollView.h"
#import "SPTextFieldHeader.h"
#import <QuartzCore/QuartzCore.h>

#define STATUS_BAR_HEIGHT 20
#define TEXT_FIELD_HEIGHT 50

@interface PictureBoxViewController ()

@property (strong, nonatomic) SPPictureScrollView *pictureGameView;
@property (strong, nonatomic) SPTextFieldHeader *textFieldHeader;

@end

@implementation PictureBoxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    CGRect textFrame = CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width, TEXT_FIELD_HEIGHT);
    self.textFieldHeader = [[SPTextFieldHeader alloc] initWithFrame:textFrame
                                                           andTitle:@""];
    
    [[self.textFieldHeader layer] setShadowOpacity:0.5];
    [[self.textFieldHeader layer] setShadowOffset:CGSizeMake(0, 2)];
    [[self.textFieldHeader layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [self.textFieldHeader.textField becomeFirstResponder];
    
    CGRect gameFrame = CGRectMake(0, STATUS_BAR_HEIGHT + TEXT_FIELD_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - (STATUS_BAR_HEIGHT + TEXT_FIELD_HEIGHT));
    self.pictureGameView = [[SPPictureScrollView alloc] initWithFrame:gameFrame];
    [self.view addSubview:self.pictureGameView];
    [self.view sendSubviewToBack:self.pictureGameView];
    
    [self.pictureGameView setScrollContentSize:224];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view addSubview:self.textFieldHeader];
}

- (void)keyboardWillChangeFrame:(id)sender
{
    
}

- (void)keyboardDidChangeFrame:(id)sender
{
    
}

@end
