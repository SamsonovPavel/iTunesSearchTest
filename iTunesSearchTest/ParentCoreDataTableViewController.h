//
//  ParentCoreDataTableViewController.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 20.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"

@interface ParentCoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

@end
