//
//  FavouritesViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "FavouritesViewController.h"
#import "FavouritesTableViewCell.h"

@interface FavouritesViewController ()

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableVIew.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    

        
        FavouritesTableViewCell *cell = (FavouritesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavouritesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
//        cell.lbtitle.text = [title objectAtIndex:indexPath.row];
//        cell.lbContent.text = [Content objectAtIndex:indexPath.row];
//        [cell.btPrice setTitle:[price objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
        return cell;
  
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2){
        
        return 243;
    }else{
        
        return 88;
        
    }
}

@end
