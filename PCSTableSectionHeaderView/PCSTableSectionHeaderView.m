//
//  PCSTableSectionHeaderView.m
//  PCSTableSectionHeaderViewExample
//
//  Created by Peter Chen on 12/9/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "PCSTableSectionHeaderView.h"

#define kMaxRightButtonWidth 250

@interface PCSTableSectionHeaderView()

//@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation PCSTableSectionHeaderView

//- (id)initWithFrame:(CGRect)frame
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
       self.customTextLabelLeftMargin = -1;
       self.customTextLabelBottomMargin = -1;
       
       /*
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPCSTableSectionHeaderView_DefaultLeftMargin, 0,
                                                                   self.frame.size.width - 2 * kPCSTableSectionHeaderView_DefaultLeftMargin, self.frame.size.height)];
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1];
        [self addSubview:self.textLabel];
        */
    }
    return self;
}

- (void)layoutSubviews {
   [super layoutSubviews];
   
   if (self.customTextLabelLeftMargin >= 0)
      self.textLabel.x = self.customTextLabelLeftMargin;
   
   if (self.customTextLabelBottomMargin >= 0)
      self.textLabel.maxY = self.height - self.customTextLabelBottomMargin;
}

- (NSString *)text {
    return self.textLabel.text;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = [text uppercaseString];
}

- (void)setRightView:(UIView *)rightView {
    [_rightView removeFromSuperview];
    self.rightButton = nil;
    
    _rightView = rightView;
    
    CGRect rightViewFrame = rightView.frame;
    rightViewFrame.origin.x = self.frame.size.width - _rightView.frame.size.width;
    rightView.frame = rightViewFrame;
    rightView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:_rightView];
}

- (void)_createRightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, kMaxRightButtonWidth, self.frame.size.height);
    [button addTarget:self action:@selector(_rightButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightView = button;
    self.rightButton = button;
}

- (UIImage *)rightButtonImage {
    return [self.rightButton imageForState:UIControlStateNormal];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    [self _createRightButton];
    [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
}

- (NSString *)rightButtonText {
    return [self.rightButton titleForState:UIControlStateNormal];
}

- (void)setRightButtonText:(NSString *)rightButtonText {
    [self _createRightButton];
    [self.rightButton setTitle:rightButtonText forState:UIControlStateNormal];
    
    CGRect buttonFrame = self.rightButton.frame;
    buttonFrame.size.width = [self.rightButton sizeThatFits:CGSizeMake(kMaxRightButtonWidth, self.frame.size.height)].width + 2 * kPCSTableSectionHeaderView_DefaultLeftMargin;
    buttonFrame.origin.x = self.frame.size.width - buttonFrame.size.width;
    self.rightButton.frame = buttonFrame;
}

- (void)_rightButtonTapped {
    [self.delegate tableHeaderViewRightButtonTapped:self];
}

@end
