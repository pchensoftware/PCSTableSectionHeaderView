//
//  MyTableController.m
//  PCSTableHeaderView
//
//  Created by Peter Chen on 12/9/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "MyTableController.h"
#import "PCSTableSectionHeaderView.h"

#define TableSectionToTest 1

@interface MyTableController () <PCSTableHeaderViewDelegate>

@property (nonatomic, assign) BOOL showHitMeString;

@end

@implementation MyTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.showHitMeString = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == TableSectionToTest) {
        return @"Header Custom";
    }
    return @"Header";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == TableSectionToTest) {
        PCSTableSectionHeaderView *headerView = [[PCSTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kPCSTableHeaderView_StandardHeight)];
        headerView.text = [self tableView:tableView titleForHeaderInSection:section];
        headerView.rightButtonText = self.showHitMeString ? @"Hit Me" : @"Okay!";
        headerView.delegate = self;
        headerView.tableViewSection = section;
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Hello";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableHeaderViewRightButtonTapped:(PCSTableSectionHeaderView *)view {
    if (view.tableViewSection == TableSectionToTest) {
        self.showHitMeString = ! self.showHitMeString;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:TableSectionToTest] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"Custom section header at index %d tapped", view.tableViewSection);
    }
}

@end
