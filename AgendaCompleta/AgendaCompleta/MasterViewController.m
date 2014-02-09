//
//  MasterViewController.m
//  AgendaCompleta
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *arrAgenda;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    arrAgenda = [NSMutableArray new];
    
    NSString *filepath = [NSHomeDirectory() stringByAppendingString:@"/Documents/agenda.plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:filepath])
    {
        arrAgenda = [NSMutableArray arrayWithContentsOfFile:filepath];
    }
    else
    {
        NSDictionary *amanda = [[NSDictionary alloc] initWithObjects:@[@"Amanda",@"Ferraz",@"9999-9999"] forKeys:@[@"Nome",@"Sobrenome",@"Telefone" ]];
        NSDictionary *eliseu = [[NSDictionary alloc] initWithObjects:@[@"Eliseu",@"Alves",@"9834-1234"] forKeys:@[@"Nome",@"Sobrenome",@"Telefone" ]];
        NSDictionary *fernando = [[NSDictionary alloc] initWithObjects:@[@"Fernando",@"Batista",@"9554-4321"] forKeys:@[@"Nome",@"Sobrenome",@"Telefone" ]];
    
        [arrAgenda addObject:amanda];
        [arrAgenda addObject:eliseu];
        [arrAgenda addObject:fernando];
        
        // Grava o array no arquivo plist
        [arrAgenda writeToFile:filepath atomically:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrAgenda.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dicDados = [arrAgenda objectAtIndex:indexPath.row];
    cell.textLabel.text = [dicDados objectForKey:@"Nome"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrAgenda removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        [[segue destinationViewController] setDicItem:[arrAgenda objectAtIndex:indexPath.row]];
    }
}

@end
