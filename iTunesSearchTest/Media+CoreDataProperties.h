//
//  Media+CoreDataProperties.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 20.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UIKit/Uikit.h"
#import "Media.h"

NS_ASSUME_NONNULL_BEGIN

@interface Media (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *artistName;
@property (nullable, nonatomic, retain) NSString *collectionName;
@property (nullable, nonatomic, retain) NSString *trackName;
@property (nullable, nonatomic, retain) NSNumber *collectionPrice;
@property (nullable, nonatomic, retain) NSNumber *trackPrice;
@property (nullable, nonatomic, retain) NSString *releaseDate;
@property (nullable, nonatomic, retain) NSString *primaryGenreName;
@property (nullable, nonatomic, retain) NSNumber *trackCount;
@property (nullable, nonatomic, retain) UIImage *artworkUrl100;

@end

NS_ASSUME_NONNULL_END
