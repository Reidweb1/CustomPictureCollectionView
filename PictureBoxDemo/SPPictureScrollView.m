//
//  SPPictureScrollView.m
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import "SPPictureScrollView.h"
#import "SPPictureBoxCell.h"

#define BUFFER 8

@interface SPPictureScrollView()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *questions;
@property (weak, nonatomic) SPPictureBoxCell *currentCell;

@end

@implementation SPPictureScrollView {
    CGFloat rowCounter;
    CGFloat cellSize;
    CGFloat yCounter;
    CGFloat numInRow;
    CGFloat placeHolderHeight;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGRect scrollFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];

    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.scrollView.alwaysBounceVertical = true;
    
    self.backgroundColor = [UIColor colorWithRed:1.0 green:0.6 blue:0 alpha:1.0];
    
    UIImage *image = [UIImage imageNamed:@"TestImage"];
    
    self.questions = [[NSMutableArray alloc] init];
    
    yCounter = BUFFER;
    cellSize = 75;
    placeHolderHeight = 50;
    
    numInRow = truncf(self.frame.size.width/(cellSize + (2*BUFFER)));
    rowCounter = [self setRowCounter];
    
    for (int j = 0; j < 25; j++) {
        for (int i = 1; i <= numInRow; i++) {
            CGRect cellRect = CGRectMake(rowCounter, yCounter, cellSize, cellSize + placeHolderHeight);
            
            SPPictureBoxCell *cell = [[SPPictureBoxCell alloc] initWithFrame:cellRect andImage:image];
            cell.delegate = self;
            
            rowCounter += (cellSize + [self setRowCounter]);
            [self.questions addObject:cell];
            [self.scrollView addSubview:cell];
        }
        rowCounter = [self setRowCounter];
        yCounter += (cellSize + placeHolderHeight + BUFFER);
    }
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, yCounter);
    [self addSubview:self.scrollView];
}

- (CGFloat)setRowCounter
{
    return ((self.frame.size.width - (numInRow * cellSize))/(numInRow + 1));
}

- (void)pictureCellPressed:(SPPictureBoxCell *)cell
{
    if (!self.currentCell) {
        self.currentCell = cell;
    } else {
        [self.currentCell unhighlightCell];
        
        self.currentCell = cell;
        [cell highlightCell];
    }
}

- (void)setScrollContentSize:(CGFloat)height
{
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, yCounter + height);
}

@end
