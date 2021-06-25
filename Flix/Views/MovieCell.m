//
//  MovieCell.m
//  Flix
//
//  Created by gracezhg on 6/23/21.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.clearColor;
    self.posterView.layer.cornerRadius = 10.0;
    self.posterView.layer.masksToBounds = YES;
    self.posterView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
