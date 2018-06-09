//
//  DriverRidesViewController.m
//  Papax
//
//  Created by VA on 6/9/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "DriverRidesViewController.h"
#import "UserTableViewCell.h"

@interface DriverRidesViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DriverRidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    
    [self.view addSubview:tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
    self.mapContainerView.frame = headerView.bounds;
    [headerView addSubview:self.mapContainerView];
    
    tableView.tableHeaderView = headerView;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

@end
