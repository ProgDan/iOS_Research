//
//  ViewController.m
//  PropertyList
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import "MotoCell.h"

@interface ViewController ()
{
    NSArray *arrMotos;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Motos" ofType:@"plist"];
    
    arrMotos = [[NSArray alloc]initWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMotos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    MotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dicDados = [arrMotos objectAtIndex:indexPath.row];
    
    cell.lblNome.text = [dicDados objectForKey:@"nome"];
    cell.imgvImage.image = [UIImage imageNamed:[dicDados objectForKey:@"imagem"]];
    
    return cell;
}

@end
