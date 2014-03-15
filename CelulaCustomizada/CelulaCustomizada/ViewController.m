//
//  ViewController.m
//  CelulaCustomizada
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    // Local onde iremos carregar o plist
    NSArray *cds;
}

@property (weak, nonatomic) IBOutlet UITableView *tabela;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *pathPLIST = [[NSBundle mainBundle]pathForResource:@"listaCds" ofType:@"plist"];
    
    // carregando o plist dentro do array
    cds = [[NSArray alloc]initWithContentsOfFile:pathPLIST];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Utilização de Célula padrão
    
    /**
     
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"idCell"];
    if (celula == nil) {
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idCell"];
    }
    
    celula.textLabel.text = [[cds objectAtIndex:indexPath.row]objectForKey:@"titulo"];
    celula.detailTextLabel.text = [[cds objectAtIndex:indexPath.row] objectForKey:@"artista"];
    celula.imageView.image = [UIImage imageNamed:[[cds objectAtIndex:indexPath.row] objectForKey:@"imagem"]];
     */

    
    // Utilização de célula customizada
    CelulaCD *celula = [tableView dequeueReusableCellWithIdentifier:@"idCelulaCD"];
    
    // quando tentamos reciclar a célula, se ele não encontrar a célula para ser reutilizada, ele automaticamente busca pelo protótipo no Story Board e faz um alloc init
    /* if (celula == nil) {
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idCell"];
    } */
    
    celula.lblTitulo.text = [[cds objectAtIndex:indexPath.row]objectForKey:@"titulo"];
    celula.lblArtista.text = [[cds objectAtIndex:indexPath.row] objectForKey:@"artista"];
    celula.lblPreco.text = [[cds objectAtIndex:indexPath.row]objectForKey:@"preco"];
    celula.lblAno.text = [[cds objectAtIndex:indexPath.row] objectForKey:@"ano"];
    celula.imgvCapa.image = [UIImage imageNamed:[[cds objectAtIndex:indexPath.row] objectForKey:@"imagem"]];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
