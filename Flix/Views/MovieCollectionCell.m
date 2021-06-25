//
//  MovieCollectionCell.m
//  Flix
//
//  Created by gracezhg on 6/24/21.
//

#import "MovieCollectionCell.h"
# import "QuartzCore/QuartzCore.h"

@implementation MovieCollectionCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.posterView.layer.cornerRadius = 5.0;
    NSLog(@"%@", self.posterView);
    self.posterView.layer.masksToBounds = YES;

}

@end
