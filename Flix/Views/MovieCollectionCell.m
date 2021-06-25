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
    self.backgroundColor = UIColor.clearColor;
    self.posterView.layer.cornerRadius = 20.0;
    self.posterView.layer.masksToBounds = YES;
    self.posterView.clipsToBounds = YES;
}

@end
