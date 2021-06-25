//
//  DetailsViewController.m
//  Flix
//
//  Created by gracezhg on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseUrlString = @"https://image.tmdb.org/t/p/original";
    NSString *posterUrLString = self.movie[@"poster_path"];
    NSString *fullPosterUrlString = [baseUrlString stringByAppendingString:posterUrLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterUrlString];
    [self.posterView setImageWithURL:posterURL];

    NSString *backdropUrlString = self.movie[@"backdrop_path"];
    NSString *fullBackdropUrlString = [baseUrlString stringByAppendingString:backdropUrlString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropUrlString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
    self.posterView.layer.cornerRadius = 10.0;
    self.posterView.layer.masksToBounds = YES;
    self.posterView.clipsToBounds = YES;
}

@end
