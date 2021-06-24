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
    // Do any additional setup after loading the view.
    
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
