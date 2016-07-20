//
//  LeftMenuViewController.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 16.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ServerRequestManager.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.255f green:0.215f blue:0.0f alpha:0.7f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LeftMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UIImage *imageCell = nil;
    
    switch (indexPath.row)
    {
        case 0:
            imageCell = [UIImage imageNamed:@"iTunes-Store"];
            cell.textLabel.text = @"Music search";
            break;
            
        case 1:
            imageCell = [UIImage imageNamed:@"Music"];
            cell.textLabel.text = @"My playlist";
            break;
            
        case 2:
            imageCell = [UIImage imageNamed:@"User"];
            cell.textLabel.text = @"About";
            break;
            
        default:
            break;
    }
    
    UIView *backgroundColorColorView = [[UIView alloc] init];
    backgroundColorColorView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.255f alpha:0.1f];
    cell.selectedBackgroundView = backgroundColorColorView;
    cell.imageView.image = imageCell;

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = nil;
    
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MediaSearchTableViewController"];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SaveMediaViewController"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AboutViewController"];
            break;
            
        default:
            break;
    }
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
