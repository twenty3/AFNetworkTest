//
//  ProductCollectionViewController.m
//  AFNetworkTest
//
//  Created by 23 on 1/7/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "ProductCollectionViewController.h"

#import "ProductCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ProductCollectionViewController ()

@property (strong) NSArray* products;

@end

@implementation ProductCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib* cellTemplateNib = [UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellTemplateNib forCellWithReuseIdentifier:@"BGProductCell"];
    
    [(UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout setItemSize:(CGSize){200.0, 200.0}];
    
    [self beginProductsRequest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Data and Requests

- (void) beginProductsRequest
{
    NSURL* productsURL = [NSURL URLWithString:@"http://api.bigcartel.com/lizparrish/products.js"];
    NSURLRequest* productsRequest = [NSURLRequest requestWithURL:productsURL];
        
    
    void (^completion)(NSURLRequest*, NSHTTPURLResponse*, id) = ^(NSURLRequest* request, NSHTTPURLResponse* response, id JSON){
        self.products = JSON;
        [self.collectionView reloadData];
    };

    void (^failure)(NSURLRequest*, NSHTTPURLResponse*, NSError* error, id) = ^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error, id JSON){
        NSLog(@"Error requestion products %@", error);
    };
    
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:productsRequest success:completion failure:failure];
    
    [operation start];
}

#pragma mark - UICollectionViewDelegate



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCollectionViewCell* cell  = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BGProductCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    //cell.productImageView.image = [UIImage imageNamed:@"test_image.jpg"];
    
    NSDictionary* product = self.products[indexPath.row];
    NSString* productImageURLString = product[@"images"][0][@"url"];
    NSURL* productImageURL = [NSURL URLWithString:productImageURLString];
    [cell.productImageView setImageWithURL:productImageURL];
    
    return cell;
}
@end
