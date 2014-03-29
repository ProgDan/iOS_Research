//
//  Livro.h
//  BancoDados
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Livro : NSManagedObject

@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSString * autor;
@property (nonatomic, retain) NSNumber * preco;
@property (nonatomic, retain) NSNumber * ano;

@end
