//
//  Pessoa.h
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <Foundation/Foundation.h>

// como declarar uma classe
// @interface NomeDaClasse : NomeClassePai
@interface Pessoa : NSObject {
    // atributos da classe, do tipo "Protected"
    int idade;
    float saldoBancario;
}

// Properties
@property (nonatomic, strong) NSString* nome;
@property (nonatomic) float altura;
@property (nonatomic, strong) NSString* enderecoComercial;

// declarando métodos da classe
-(void)falar;
-(int)getIdade; // perguntar para a classe pessoa a sua idade e irá retornar um inteiro (idade)

// método com parâmetro
// -(tipoRetorno) nomeMetodo : (tipoParametro) nomeParametro
-(void)falarTexto:(NSString*) fala;

// método com 2 ou mais parâmetros
-(void)andarRua1:(NSString*) rua1 eRua2: (NSString *) rua2;

// Construtor customizado
-(id)initWithNome:(NSString*)nome withIdade:(int)pIdade;

@end
