Class {
	#name : 'BookSanitizerVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'visitors'
	],
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
BookSanitizerVisitor >> addVisitor: aVisitor [

	visitors add: aVisitor
]

{ #category : 'visiting' }
BookSanitizerVisitor >> initialize [
	
	super initialize.
	visitors := OrderedCollection new
]

{ #category : 'visiting' }
BookSanitizerVisitor >> removeVisitor: aVisitor [

	visitors remove: aVisitor
]

{ #category : 'visiting' }
BookSanitizerVisitor >> visitCode: aCodeBlock [

	visitors do: [ :visitor | visitor visitCode: aCodeBlock ]
]

{ #category : 'visiting' }
BookSanitizerVisitor >> visitHeader: aHeader [

	visitors do: [ :visitor | visitor visitHeader: aHeader ]
]

{ #category : 'visiting' }
BookSanitizerVisitor >> visitParagraph: aParagraph [

	visitors do: [ :visitor | visitor visitHeader: aParagraph ]
]
