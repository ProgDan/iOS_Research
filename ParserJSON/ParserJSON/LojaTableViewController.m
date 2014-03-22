//
//  LojaTableViewController.m
//  ParserJSON
//
//  Created by Daniel Arndt Alves on 3/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "LojaTableViewController.h"

@interface LojaTableViewController ()

@property(nonatomic, strong) NSArray *listaLoja;


@end

@implementation LojaTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Localizando o arquivo no projeto
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loja" ofType:@"json"];
    
    // Carregando os dados contidos no arquivo
    NSData *dadosArquivo = [NSData dataWithContentsOfFile:path];
    
    // Convertendo o arquivo para uma estrutura conhecida - vetor
    self.listaLoja = [NSJSONSerialization JSONObjectWithData:dadosArquivo options:NSJSONReadingAllowFragments error:nil];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // Curiosidade
    // Como salver um vetor em formato JSON
    NSData *dadosParaSalvar = [NSJSONSerialization dataWithJSONObject:self.listaLoja options:NSJSONWritingPrettyPrinted error:nil];
    
    // Definir onde salvar
    NSString *pathDocuments = [NSHomeDirectory() stringByAppendingString:@"/Documents/arquivoSalvo.json"];
    
    // Salvar!
    [dadosParaSalvar writeToFile:pathDocuments atomically:YES];
    
    NSLog(@"%@", pathDocuments);
    
    // Extra
    // Como qubrar a string em várias partes
    NSString *nomeImagem = @"foto.jpg";
    NSArray *subStrings = [nomeImagem componentsSeparatedByString:@"."];
    
    NSLog(@"%@", subStrings);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.listaLoja.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.listaLoja[indexPath.row][@"album"];
    cell.detailTextLabel.text = self.listaLoja[indexPath.row][@"album"];
    
/*
    NSString *path = [[NSBundle mainBundle] pathForResource:self.listaLoja[indexPath.row][@"imagem"] ofType:@""];
    cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:path];
 */
    
    cell.imageView.image = [UIImage imageNamed:self.listaLoja[indexPath.row][@"imagem"]];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
