//
//  MediaSearchTableViewController.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 16.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequestManager.h"

@interface MediaSearchTableViewController : UIViewController <UISearchBarDelegate,
                                                              UITableViewDelegate, UITableViewDataSource,
                                                              ServerRequestManagerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)saveButtonAction:(UIButton *)sender;

@end
