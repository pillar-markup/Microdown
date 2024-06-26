Class {
	#name : 'MicMetaDataBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicMetaDataBlockTest >> subjectClass [ 
	^ MicMetaDataBlock 
]

{ #category : 'tests - metadata properties' }
MicMetaDataBlockTest >> testAtKey [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root := parser parse: source.
	metadata := root children first.
	self assert: (metadata atKey: 'authors') equals: 'S. Ducasse'.
	self assert: (metadata atKey: 'title') equals: 'Pharo by Example'
]

{ #category : 'tests - metadata properties' }
MicMetaDataBlockTest >> testAtKeyPut [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root := parser parse: source.
	metadata := root children first.
	metadata atKey: 'title' put: 'Pilote'.
	self assert: (metadata includesKey: 'title').
	self assert: (metadata atKey: 'title') equals: 'Pilote'.
]

{ #category : 'tests' }
MicMetaDataBlockTest >> testCorrectJSONMetaDataProducesDictionary [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: 'authors') equals: 'S. Ducasse'.
	self assert: (metadata body at: 'title') equals: 'Pharo by Example'.
]

{ #category : 'tests' }
MicMetaDataBlockTest >> testCorrectMetaDataWithEmptyLinesProduceJSON [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"




}'.

	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: 'authors') equals: 'S. Ducasse'.
	self assert: (metadata body at: 'title') equals: 'Pharo by Example'.
]

{ #category : 'tests - metadata properties' }
MicMetaDataBlockTest >> testCreatingAnInstanceInitializeTheMetadatDictionary [

	| metadata |
	self skip.
	metadata := MicMetaDataBlock new.
	self assert: metadata body isNotNil
]

{ #category : 'tests - metadata properties' }
MicMetaDataBlockTest >> testIncludesKey [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root := parser parse: source.
	metadata := root children first.
	self assert: (metadata includesKey: 'authors').
	self assert: (metadata includesKey: 'title').
	self deny: (metadata includesKey: 'title222')
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testMetaDataDictionaryIsInitializedDuringParseTime [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root := parser parse: source.
	metadata := root children first.
	self assert: metadata body isNotNil 
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testMetaDataEatsOtherBlocks [
	"this is normal since 
{

....

without closing statement (}) is just an unclosed block and since metadata can be a multilines
then it eats.

"
	| source root metadata |
	source := '"author": "S Ducasse"', String cr,
	HeaderMarkup, 'newheader here'.
	root :=  parser parse:  MetaDataOpeningBlockMarkup , String cr, source.
	self assert: root children size equals: 1.
	metadata := root children first. 
	self assert: (metadata isKindOf: MicMetaDataBlock). 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: source.
	self assert: metadata bogusParsing
	
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testParse [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}

# header'.
	root := parser parse: source.
	metadata := root children first.
	self assert: root children size equals: 2.
	self assert: (metadata isKindOf: MicMetaDataBlock). 
	
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" 
"title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse" 
"title" : "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents2 [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse",
title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse",
title" : "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]

{ #category : 'tests - parsing' }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents3 [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse",
"title" "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse",
"title" "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]
