//
//  MoviesViewController.m
//  Flix
//
//  Created by gracezhg on 6/23/21.
//

#import "MoviesViewController.h"
#import "DetailsViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSArray *filteredMovies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    [self fetchMovies];
    self.filteredMovies = self.movies;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = UIColor.whiteColor;
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // header styling
    [self.searchBar setImage:[UIImage imageNamed:@"darkModeSearch"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    self.searchBar.searchTextField.backgroundColor
    = [UIColor colorWithRed:64.0f/255.0f
                      green:69.0f/255.0f
                       blue:82.0f/255.0f
                      alpha:1.0f];
    self.searchBar.searchTextField.textColor = UIColor.whiteColor;
    self.searchBar.layer.borderWidth = 0;
    self.searchBar.layer.borderColor = [[UIColor clearColor] CGColor];
    self.profileImg.layer.cornerRadius = 35;
    self.profileImg.layer.masksToBounds = YES;

    // dark mode gradient
    UIColor *leftColor = [UIColor colorWithRed:16.0/255.0 green:33.0/255.0 blue:44.0/255.0 alpha:1.0];
    UIColor *middleColor = [UIColor colorWithRed:30.0/255.0 green:25.0/255.0 blue:47.0/255.0 alpha:1.0];
    UIColor *rightColor = [UIColor colorWithRed:30.0/255.0 green:25.0/255.0 blue:47.0/255.0 alpha:1.0];
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)leftColor.CGColor, (id)middleColor.CGColor,(id)rightColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot get movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
               
               [self presentViewController:alert animated:YES completion:^{
               }];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
               }];
               [alert addAction:cancelAction];
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               }];
               [alert addAction:okAction];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movies = dataDictionary[@"results"];
               self.filteredMovies = self.movies;
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    float rating = [movie[@"vote_average"] floatValue];
    cell.ratingLabel.text = [NSString stringWithFormat:@"%.1f", rating];
    cell.yearLabel.text = [movie[@"release_date"] substringWithRange:NSMakeRange(0, 4)];
    
    NSString *baseUrlString = @"https://image.tmdb.org/t/p/original";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterUrlString = [baseUrlString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterUrlString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
         NSPredicate *filterByName = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
             return [evaluatedObject[@"title"] containsString:searchText];
         }];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:filterByName];
    }
     else {
         self.filteredMovies = self.movies;
     }
     [self.tableView reloadData];
};

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
