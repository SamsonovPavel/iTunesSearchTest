//
//  SaveMediaTableViewCell.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 20.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveMediaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *primaryGenreNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkUrl100;

@end