//
//  PCSTableSectionHeaderView.h
//  PCSTableSectionHeaderViewExample
//
//  Created by Peter Chen on 12/9/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPCSTableSectionHeaderView_StandardHeight 44
#define kPCSTableSectionHeaderView_DefaultLeftMargin 15

@class PCSTableSectionHeaderView;

@protocol PCSTableSectionHeaderViewDelegate <NSObject>
- (void)tableHeaderViewRightButtonTapped:(PCSTableSectionHeaderView *)view;
@end

@interface PCSTableSectionHeaderView : UITableViewHeaderFooterView

//@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, strong) NSString *text; // Will convert string to uppercase. ie. Convenience for self.textLabel.text = [mystring uppercaseString]

@property (nonatomic, strong) UIView *rightView; // This will be automatically right-aligned and vertically centered to the header view

// Similar to, but more convenient than, creating a UIButton and setting rightView to it
@property (nonatomic, readonly) UIButton *rightButton;
@property (nonatomic, strong) UIImage *rightButtonImage;
@property (nonatomic, strong) NSString *rightButtonText;

@property (nonatomic, assign) int tableViewSection;
@property (nonatomic, weak) id<PCSTableSectionHeaderViewDelegate> delegate;

@end
