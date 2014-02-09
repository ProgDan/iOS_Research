//
//  ViewController.m
//  Tabela
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import "DetalheViewController.h"

@interface ViewController ()
{
    NSArray *arrAgenda, *arrAmigos;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    arrAgenda = [[NSArray alloc]initWithObjects:@"Maria",@"Isabela",@"Joana",@"Tereza", nil];
    arrAmigos = [[NSArray alloc]initWithObjects:@"Daniel",@"Fernando",@"Eliseu", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [arrAmigos count];

    return [arrAgenda count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(indexPath.section == 0)
        cell.textLabel.text = [arrAmigos objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [arrAgenda objectAtIndex:indexPath.row];
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Amigos";
    else
        return @"Agenda";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetalheViewController *detalhe = [story instantiateViewControllerWithIdentifier:@"Detalhe"];

    if(indexPath.section == 0)
        detalhe.strNome = [arrAmigos objectAtIndex:indexPath.row];
    else
        detalhe.strNome = [arrAgenda objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detalhe animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
