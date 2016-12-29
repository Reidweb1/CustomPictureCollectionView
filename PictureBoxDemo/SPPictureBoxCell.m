//
//  SPPictureBoxCell.m
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import "SPPictureBoxCell.h"

#define BUFFER 8

@interface SPPictureBoxCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *hintLabel;
@property (strong, nonatomic) UILabel *answerLabel;

@end

@implementation SPPictureBoxCell {
    CGFloat cellSize;
}

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView:image withHints:true];
    }
    return self;
}

- (void)setUpView:(UIImage *)image withHints:(BOOL)hasHints
{
    cellSize = 75;
    
    UIFont *theFont = [UIFont boldSystemFontOfSize:10.0];
    NSDictionary *attributes = @{ NSFontAttributeName : theFont };
    
    if (hasHints) {
        NSString *hintString = @"Test Hint";
        
        CGSize hintSize = [hintString sizeWithAttributes:attributes];
        
        CGRect hintFrame = CGRectMake(BUFFER, BUFFER, self.frame.size.width - (2*BUFFER), hintSize.height);
        self.hintLabel = [[UILabel alloc] initWithFrame:hintFrame];
        
        self.hintLabel.font = theFont;
        self.hintLabel.textAlignment = NSTextAlignmentCenter;
        
        self.hintLabel.text = hintString;
        
        [self addSubview:self.hintLabel];
    }
    
    CGRect imageFrame;
    if (hasHints) {
        imageFrame = CGRectMake(BUFFER, self.hintLabel.frame.size.height + (2*BUFFER), self.frame.size.width - (2*BUFFER), cellSize - (2*BUFFER));
    } else {
        imageFrame = CGRectMake(BUFFER, BUFFER, cellSize - (2*BUFFER), cellSize - (2*BUFFER));
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    [self.imageView setBackgroundColor:[UIColor blackColor]];
    self.imageView.image = image;
    
    [self addSubview:self.imageView];
    
    NSString *answerString = @"This is a test answer";
    
    CGSize answerSize = [answerString sizeWithAttributes:attributes];
    
    CGRect answerFrame = CGRectMake(BUFFER, self.imageView.frame.origin.y + self.imageView.frame.size.height + BUFFER, self.frame.size.width - (2*BUFFER), answerSize.height * 2);
    
    self.answerLabel = [[UILabel alloc] initWithFrame:answerFrame];
    
    self.answerLabel.font = theFont;
    self.answerLabel.textAlignment = NSTextAlignmentCenter;
    self.answerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.answerLabel.numberOfLines = 0;
    
    self.answerLabel.text = answerString;
    
    [self.answerLabel layer].cornerRadius = 10;
    self.answerLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.1];
    
    self.answerLabel.hidden = false;
    [self addSubview:self.answerLabel];
    
    [self layer].cornerRadius = 10;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewTapped)];
    tapGesture.cancelsTouchesInView = false;
    [self addGestureRecognizer:tapGesture];
}

- (void)viewTapped
{
    [self.delegate pictureCellPressed:self];
}

- (void)highlightCell
{
    self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
}

- (void)unhighlightCell
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
}

@end
