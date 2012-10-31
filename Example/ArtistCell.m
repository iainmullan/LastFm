//
//  ArtistCell.m
//  Example
//
//  Created by Kevin Renskers on 31-10-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import "ArtistCell.h"
#import "UIImageView+WebCache.h"
#import "LastFm.h"

@interface ArtistCell ()
@property (strong, nonatomic) NSOperation *operation;
@end

@implementation ArtistCell

- (void)loadLastFmDataForArtist:(NSString *)artist {
    self.operation = [[LastFm sharedInstance] getInfoForArtist:artist successHandler:^(NSDictionary *result) {
        NSURL *image = [result objectForKey:@"image"];
        if (image) {
            [self.imageView setImageWithURL:image placeholderImage:[UIImage imageNamed:@"Icon"]];
        }
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@ scrobbles", [result objectForKey:@"playcount"]];
    } failureHandler:nil];
}

- (void)prepareForReuse {
    [self.operation cancel];
    [self.imageView cancelCurrentImageLoad];
    [super prepareForReuse];
}

@end
