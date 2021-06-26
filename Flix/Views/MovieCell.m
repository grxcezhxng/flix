//
//  MovieCell.m
//  Flix
//
//  Created by gracezhg on 6/23/21.
//

#import "MovieCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.clearColor;
    self.posterView.layer.cornerRadius = 10.0;
    self.posterView.layer.masksToBounds = YES;
    self.posterView.clipsToBounds = YES;
    
    self.ratingBubble.layer.cornerRadius = 15;
    self.ratingBubble.layer.masksToBounds = YES;
    self.ratingBubble.layer.borderWidth = 0.5;
    self.ratingBubble.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    
    self.yearBubble.layer.cornerRadius = 15;
    self.yearBubble.layer.masksToBounds = YES;
    self.yearBubble.layer.borderWidth = 0.5;
    self.yearBubble.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    self.yearBubble.layer.zPosition = -1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
