//
//  DocumentoCloud.h
//  Cloud
//
//  Created by Eduardo Lima on 3/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentoCloud : UIDocument

//Aqui criamos as property para salvar os dados que queremos mandar para o iCloud
@property (nonatomic, strong) NSMutableArray *anotacoes;

@end
