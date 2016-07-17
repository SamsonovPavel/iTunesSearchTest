//
//  LeftMenuViewController.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 16.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
