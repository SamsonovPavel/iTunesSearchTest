//
//  SaveMediaViewController.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 20.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "SaveMediaViewController.h"
#import "SaveMediaTableViewCell.h"
#import "CoreDataManager.h"
#import "MediaLocation.h"
#import "Media.h"
#import "CoreDataManager.h"
#import "UIView+UITableViewCell.h"

@interface SaveMediaViewController ()

@end

@implementation SaveMediaViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"menuMediaTabBarImage"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
    
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - SlideNavigationController Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([Media class])
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"artistName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SaveMediaCell";
    SaveMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    
    UIView *backgroundColorColorView = [[UIView alloc] init];
    backgroundColorColorView.backgroundColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.1f];
    cell.selectedBackgroundView = backgroundColorColorView;
    
    return cell;
}

#pragma mark - ConfigureCell

- (void)configureCell:(SaveMediaTableViewCell *)cell withObject:(NSManagedObject *)object
{
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    Media *media = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.artistNameLabel.text = media.artistName;
    cell.collectionNameLabel.text = media.collectionName;
    cell.trackNameLabel.text = media.trackName;
    cell.collectionPriceLabel.text = [NSString stringWithFormat:@"%1.2f", [media.collectionPrice floatValue]];
    cell.trackPriceLabel.text = [NSString stringWithFormat:@"%1.2f", [media.trackPrice floatValue]];
    cell.releaseDateLabel.text = media.releaseDate;
    cell.primaryGenreNameLabel.text = media.primaryGenreName;
    cell.trackCountLabel.text = [NSString stringWithFormat:@"%ld", (long)[media.trackCount integerValue]];
    cell.artworkUrl100.image = media.artworkUrl100;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deleteButtonAction:(UIButton *)sender
{
    NSError *error = nil;
    UITableViewCell *cell = [sender superTableViewCell];
    
    if (cell)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Media *media = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.managedObjectContext deleteObject:media];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Create error - %@", [error localizedDescription]);
        }
        
        [self.tableView reloadData];
    }
}
@end














