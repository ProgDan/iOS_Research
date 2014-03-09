//
//  ViewController.m
//  AssetsGestos
//
//  Created by Daniel Arndt Alves on 3/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import "GestosViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *grid;

@property (strong, nonatomic) NSMutableArray *listaFotos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.bibliotecaFotos = [ALAssetsLibrary new];
    self.listaFotos = [NSMutableArray new];
    
    // Bloco utilizado para cada album encontrado
    void (^enumerarGrupos)(ALAssetsGroup*, BOOL*);
    
    enumerarGrupos = ^(ALAssetsGroup *album, BOOL *stop){
        // O que acontece quando um álbum é encontrado
        [album enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            // O que acontece quando um asset (foto/vídeo) é encontrado
            if ([result valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                // FOTO! - Salvar em um vetor que vai ser usado para popular a tela
                [self.listaFotos addObject:result];
                
                NSLog(@"Quantidade de fotos encontradas: %d", self.listaFotos.count);
                
                [self.grid reloadData];
            }
        }];
    };
    
    [self.bibliotecaFotos enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:enumerarGrupos failureBlock:^(NSError *error) {
        NSLog(@"Erro na enumeração: %@", error.localizedFailureReason);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)converterAssetParaImage:(NSIndexPath *)indexPath isThumbnail:(BOOL) isThumbnail {
    // ALAsset > UIImage (miniatura)
    ALAsset *recurso = [self.listaFotos objectAtIndex:indexPath.row];
    CGImageRef referenciaImagem;
    if (isThumbnail) {
        referenciaImagem = recurso.thumbnail;
    }
    else {
        referenciaImagem = recurso.defaultRepresentation.fullResolutionImage;
    }
    UIImage *imagem = [UIImage imageWithCGImage:referenciaImagem];
    return imagem;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // Cadastrar o tipo de célula usada na reciclagem
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"meuItem"];
    
    // Criação da célula
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"meuItem" forIndexPath:indexPath];
    
    // Configuração do conteúdo
    UIImage *imagem;
    imagem = [self converterAssetParaImage:indexPath isThumbnail:YES];
    
    UIImageView *foto = [[UIImageView alloc] initWithImage:imagem];
    foto.frame = item.bounds;
    
    [item.contentView addSubview:foto];
    
    // Retorna o objeto criado
    return item;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listaFotos.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selecionou item!");
    
    // Transição de telas
    // Passar a imagem selecionada por parâmetro
    [self performSegueWithIdentifier:@"segueTelaCheia" sender:nil];
    
}

// Chamado momentos antes da transição acontecer
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GestosViewController *telaDestino = segue.destinationViewController;
    
    NSIndexPath *index = [self.grid.indexPathsForSelectedItems lastObject];
    
    telaDestino.imagemSelecionada = [self converterAssetParaImage:index isThumbnail:NO];
}

@end
