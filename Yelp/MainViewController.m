//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Business.h"
#import "MainViewController.h"
#import "YelpClient.h"
#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"
#import "FiltersViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *yelpList;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
- (void) fetchBusinessesWithQuery: (NSString* ) query params: (NSDictionary*) params;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
   
        [self fetchBusinessesWithQuery:@"Restaurants" params:nil];
          }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.yelpList.delegate = self;
    self.yelpList.dataSource = self;
    
    [self.yelpList registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    self.yelpList.rowHeight = UITableViewAutomaticDimension;
    self.yelpList.estimatedRowHeight = 85;
    self.title=@"Yelp";
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(onFilterButton)];

    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search Yelp Here";
    self.searchBar.showsCancelButton = YES;
    self.searchBar.frame = CGRectMake(0,0,250,44);
    self.searchBar.translucent = YES;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.showsCancelButton = NO;
    UIView *barWrapper = [[UIView alloc] initWithFrame:CGRectMake(0,0,250,44)];
    [barWrapper addSubview:self.searchBar];
    self.navigationItem.titleView = barWrapper;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) fetchBusinessesWithQuery: (NSString* ) query params: (NSDictionary*) params{
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSArray *businessesArray = response[@"businesses"];
        if([businessesArray count] > 0){
            self.businesses = [Business businessesWithDictionaries:businessesArray];
            [self.yelpList reloadData];
        }else{
            self.businesses = [NSArray new];
            [self.yelpList reloadData];
        }
        NSLog(@"response: %@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}



#pragma Table methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return self.businesses.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    
    cell.business = self.businesses[indexPath.row];
    return cell;
}

#pragma marks - delegate methods
-(void) filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters{
    [self fetchBusinessesWithQuery:@"Restaurants" params:filters];
    NSLog(@"fire new delegate: %@", filters);
}

#pragma private Methods
-(void) onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.navigationBar.barTintColor = [UIColor redColor];
    [self presentViewController:nvc animated:YES completion:nil];
}


#pragma mark - Search bar methods
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString* searchText = searchBar.text;
   [self fetchBusinessesWithQuery:searchText params:nil];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

@end
