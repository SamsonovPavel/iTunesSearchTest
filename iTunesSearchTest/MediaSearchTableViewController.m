//
//  MediaSearchTableViewController.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 16.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "MediaSearchTableViewController.h"
#import "CoreDataManager.h"
#import "MediaLocation.h"
#import "MediaTableViewCell.h"
#import "Media.h"
#import "UIView+UITableViewCell.h"

@interface MediaSearchTableViewController ()

@property (strong, nonatomic) NSMutableArray *requestArray;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) ServerRequestManager *requestManager;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MediaSearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _managedObjectContext = [[CoreDataManager coreDataSharedManager] managedObjectContext];
//    [self deleteAllObjectsFromCoreData];
    
    self.requestArray = [NSMutableArray array];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint activityIndicatorCenter = CGPointMake(CGRectGetMidX(self.tableView.bounds), CGRectGetMidY(self.tableView.bounds));
    self.activityIndicator.center = activityIndicatorCenter;
    [self.tableView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"menuMediaTabBarImage"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.requestManager = [[ServerRequestManager alloc] init];
    self.requestManager.delegate = self;
    [self serverRequestManagerLaunch:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)deleteAllObjectsFromCoreData
{
    NSFetchRequest *allFetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Media class])];
    NSError *error = nil;
    NSArray *allArray = [self.managedObjectContext executeFetchRequest:allFetchRequest error:&error];
    
    if ([allArray count] > 0)
    {
        for (id object in allArray)
        {
            [self.managedObjectContext deleteObject:object];
        }
    } else if (error != nil) {
        NSLog(@"Delete error - %@", [error localizedDescription]);
    }
    [self.managedObjectContext save:nil];
}


#pragma mark - additionalMethods

- (void)serverRequestManagerLaunch:(NSString *)searchString
{
    [self.requestManager postUsersServerWithString:searchString OnSuccess:^(NSArray *array) {
        
        if ([self.requestArray count] > 0) {
            [self.requestArray removeAllObjects];
        }
        
        [self.requestArray addObjectsFromArray:array];
        
    } onFailure:^(NSError *error, NSInteger statusCode) { // for further expansion
        
    } loading:^(BOOL load) {  // for further expansion
        
    }];
}

- (void)stopAnimationIndicator
{
    if ([self.activityIndicator isAnimating]) {
        [self.activityIndicator stopAnimating];
    }
}

- (void)alertViewMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Download Failed"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ServerRequestManagerDelegate

- (void)downloadIsComplete:(ServerRequestManager *)manager
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimationIndicator];
        [self.tableView reloadData];
    });
}

- (void)downloadFailed:(ServerRequestManager *)manager
{
    [self alertViewMessage];
}

#pragma mark - SlideNavigationController Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.requestArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MediaCell";
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    MediaLocation *media = [self.requestArray objectAtIndex:indexPath.row];
    cell.artworkUrl100.image = media.artworkUrl100;
    cell.artistNameLabel.text = media.artistName;
    cell.collectionNameLabel.text = media.collectionName;
    cell.trackNameLabel.text = media.trackName;
    cell.collectionPriceLabel.text = [NSString stringWithFormat:@"Collection:%1.2f$", media.collectionPrice];
    cell.trackPriceLabel.text = [NSString stringWithFormat:@"Track:%1.2f$", media.trackPrice];
    
    NSRange releaseDateRange = NSMakeRange(0, 10);
    NSString *releaseDateString = [media.releaseDate substringWithRange:releaseDateRange];
    cell.releaseDateLabel.text = releaseDateString;
    
    cell.primaryGenreNameLabel.text = media.primaryGenreName;
    
    NSString *trackCountString = [NSString stringWithFormat:@"Count:%lu", (unsigned long)media.trackCount];
    cell.trackCountLabel.text = trackCountString;
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.activityIndicator startAnimating];
    [self serverRequestManagerLaunch:searchText];
    
    if ([searchText length] == 0)
    {
        NSArray *artistArray = @[@"jack+johnson", @"jack", @"Madonna", @"Selena Gomez", @"Mr. President",
                                 @"Michael Jackson", @"Pink Floyd", @"Britney Spears", @"Rammstein", @"Status Quo"];
        NSString *string = artistArray[arc4random_uniform(10)];
        [self serverRequestManagerLaunch:string];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createNewMediaInCoreData:(MediaLocation *)mediaParam
{
    Media *newMedia = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Media class])
                                                     inManagedObjectContext:self.managedObjectContext];
    if (newMedia != nil)
    {
        newMedia.artistName = mediaParam.artistName;
        newMedia.collectionName = mediaParam.collectionName;
        newMedia.trackName = mediaParam.trackName;
        newMedia.collectionPrice = [NSNumber numberWithFloat:mediaParam.collectionPrice];
        newMedia.trackPrice = [NSNumber numberWithFloat:mediaParam.trackPrice];
        newMedia.releaseDate = mediaParam.releaseDate;
        newMedia.primaryGenreName = mediaParam.primaryGenreName;
        newMedia.trackCount = [NSNumber numberWithInteger:mediaParam.trackCount];
        newMedia.artworkUrl100 = mediaParam.artworkUrl100;
        
        NSError *eventsError = nil;
        if (![self.managedObjectContext save:&eventsError]) {
            NSLog(@"Create error - %@", [eventsError localizedDescription]);
        }
    }
}

- (IBAction)saveButtonAction:(UIButton *)sender
{
    UITableViewCell *cell = [sender superTableViewCell];
    
    if (cell)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        MediaLocation *media = [self.requestArray objectAtIndex:indexPath.row];
        [self createNewMediaInCoreData:media];
        
        NSMutableArray *tempArray = self.requestArray;
        [tempArray removeObject:media];
        self.requestArray = tempArray;
        
        [self.tableView reloadData];
    }
}
@end



















