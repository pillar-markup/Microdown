"
I'm a simple class to determine what should be done when a monospaced text is displayed.
I'm like a little interpreter that will compute the entity that should be browsed.
I only work with in image entity.


```language=PharoExpression
| sem |
sem := MicSemanticAction from: 'Point class>>#x:y:'.
sem hasEntity
>>> true
sem browse
```

The following entities can be referenced. 

- A class: `Point`
- A method `Point>>#degrees` as well as a class method `Point class>>x:y:`
- A package: `Microdown`

"
Class {
	#name : 'MicSemanticAction',
	#superclass : 'Object',
	#instVars : [
		'entity',
		'tokens'
	],
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'instance creation' }
MicSemanticAction class >> from: aString [

	| contents |
	contents := (OCScanner on: (ReadStream on: aString)) contents.
	^ self fromTokens: (contents collect: [ :e | e value ])
]

{ #category : 'instance creation' }
MicSemanticAction class >> fromTokens: anArray [ 
	^ self new fromTokens: anArray; yourself
]

{ #category : 'instance creation' }
MicSemanticAction >> computeEntity [
	"Try to guess what the text is:
		Point
		Point class
		Point >> #setX:setY:
		Point class >> #setX:setY:
		#'PackageNameWithDashes'
		Literals such as nil, true or 10 refer to nothing."

	(tokens isEmpty or: [ tokens size > 4 ]) ifTrue: [ ^ self ].
	tokens first isString ifFalse: [ ^ self ].
	"either 'Point' for a class or #'''System-Caching''' for a package"
	tokens size = 1 ifTrue: [
			self getClassOrNil ifNil: [ self getPackageOrNil ifNil: [ self getTagOrNil ] ].
			^ self ].
	"only 'Point class'"
	tokens size = 2 ifTrue: [
			self getMetaClassOrNil.
			^ self ].
	self computeMethodEntity
]

{ #category : 'private' }
MicSemanticAction >> computeMethodEntity [
	"Find the method of a text such as Point >> #setX:setY: or Point class >> #x:y:"

	tokens second = '>>' ifTrue: [
			self getClassOrNil.
			^ self getCompiledMethodFrom: 3 ].
	tokens second = 'class' ifFalse: [ ^ self ].
	self getMetaClassOrNil.
	self getCompiledMethodFrom: 4
]

{ #category : 'accessing' }
MicSemanticAction >> entity [
	^ entity
]

{ #category : 'instance creation' }
MicSemanticAction >> fromTokens: anArray [
	
	anArray ifEmpty: [ ^ self].
	tokens := anArray.
	self computeEntity.
]

{ #category : 'instance creation' }
MicSemanticAction >> getClassOrNil [

	self class environment 
			at: tokens first asString asSymbol  
			ifPresent: [ :cl | entity := cl ]
			ifAbsent: [ ].
	^ entity
				
]

{ #category : 'instance creation' }
MicSemanticAction >> getCompiledMethodFrom: start [

	"
	| selector |
	selector := String streamContents: [ :str |
		start to: tokens size do: [ :each | str nextPutAll: (tokens at: each) ] ].
	^ selector
	No we do not want to support space in method selector!
	"
	entity ifNotNil: [  
		entity 
			compiledMethodAt: (tokens at: start) 
			ifPresent: [ :cm | entity := cm ] 
			ifAbsent: [ entity := nil ] ]
]

{ #category : 'instance creation' }
MicSemanticAction >> getMetaClassOrNil [

	self class environment 
			at: tokens first asString asSymbol  
			ifPresent: [ :cl | entity := cl. 
					tokens second = 'class' 
						ifTrue: [ entity := entity class ]
						ifFalse: [ entity := nil "because we do not want Point foo" ] ]
			ifAbsent: [ ].
	^ entity
				
]

{ #category : 'instance creation' }
MicSemanticAction >> getPackageOrNil [

	entity := self class packageOrganizer packageNamed: tokens first asString ifAbsent: [ nil ].
	^ entity
				
]

{ #category : 'instance creation' }
MicSemanticAction >> getTagOrNil [
	"A tag is written with the name of its package, a dash and its own name, e.g. #'Microdown-Model'."

	| tagName |
	tagName := tokens first asString.
	self class packageOrganizer packages do: [ :package |
			| prefixSize |
			prefixSize := package name size.
			((tagName beginsWith: package name) and: [ (tagName at: prefixSize + 1 ifAbsent: [ nil ]) = $- ]) ifTrue: [
				package tagNamed: (tagName allButFirst: prefixSize + 1) ifPresent: [ :tag | ^ entity := tag ] ] ].
	^ entity := nil
]

{ #category : 'testing' }
MicSemanticAction >> hasEntity [

	^ entity isNotNil
]

{ #category : 'accessing' }
MicSemanticAction >> tokens: aCol [

	tokens := aCol
]
