//
//  SPTextFieldHeader.m
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/9/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import "SPTextFieldHeader.h"

#define BUFFER 8

@interface SPTextFieldHeader()

@property (strong, nonatomic) UIButton *giveUpButton;
@property (strong, nonatomic) UIButton *helpButton;

@end

@implementation SPTextFieldHeader {
    BOOL isClassic;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        isClassic = true;
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.backgroundColor = [UIColor colorWithRed:0.956 green:0.956 blue:0.956 alpha:1.0];

    NSString *giveUpString = @"Give Up";
    UIFont *theFont = [UIFont boldSystemFontOfSize:12.0];
    NSDictionary *attributes = @{ NSFontAttributeName : theFont };
    
    CGSize giveUpSize = [giveUpString sizeWithAttributes:attributes];
    
    self.giveUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.giveUpButton.frame = CGRectMake(self.frame.size.width - giveUpSize.width - (2*BUFFER), BUFFER, giveUpSize.width + BUFFER, self.frame.size.height - (2*BUFFER));
    
    [self.giveUpButton addTarget:self
                          action:@selector(giveUpButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.giveUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.giveUpButton setTitle:giveUpString forState:UIControlStateNormal];
    [self.giveUpButton.titleLabel setFont:theFont];
    
    [self.giveUpButton setBackgroundColor:[UIColor colorWithRed:1.0 green:0.3 blue:0.3 alpha:1.0]];
    [self.giveUpButton layer].cornerRadius = 5;
    
    if (isClassic) {
        NSString *helpString = @"Help";
        
        self.helpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.helpButton.frame = CGRectMake(self.giveUpButton.frame.origin.x - self.giveUpButton.frame.size.width - BUFFER, BUFFER, giveUpSize.width + BUFFER, self.frame.size.height - (2*BUFFER));
        
        [self.helpButton addTarget:self
                            action:@selector(helpButtonPressed)
                  forControlEvents:UIControlEventTouchUpInside];
        
        [self.helpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.helpButton setTitle:helpString forState:UIControlStateNormal];
        [self.helpButton.titleLabel setFont:theFont];
        
        [self.helpButton setBackgroundColor:[UIColor colorWithRed:0.3 green:1.0 blue:0.3 alpha:1.0]];
        [self.helpButton layer].cornerRadius = 5;
        
        [self addSubview:self.helpButton];
    }
    
    [self addSubview:self.giveUpButton];
    
    CGRect textFieldFrame;

    if (isClassic) {
        textFieldFrame = CGRectMake(BUFFER, BUFFER, self.helpButton.frame.origin.x - (2*BUFFER), self.frame.size.height - (2*BUFFER));
    } else {
        textFieldFrame = CGRectMake(BUFFER, BUFFER, self.frame.size.width - giveUpSize.width - (4*BUFFER), self.frame.size.height - (2*BUFFER));
    }
    
    self.textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    self.textField.backgroundColor = [UIColor whiteColor];
    
    [self.textField layer].cornerRadius = 5;
    [self.textField layer].borderWidth = 1.0;
    [self.textField layer].borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0].CGColor;
    
    [self addSubview:self.textField];
}

- (void)giveUpButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(giveUpButtonAction)]) {
        [self.delegate giveUpButtonAction];
    }
}

- (void)helpButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(helpButtonAction)]) {
        [self.delegate helpButtonAction];
    }
}

@end
