Class {
	#name : #MicToc,
	#superclass : #MicElement,
	#instVars : [
		'name',
		'level',
		'children',
		'fileReference'
	],
	#category : #'Microdown - HTML'
}

{ #category : #testing }
MicToc class >> isAbstract [
	^ false
]

{ #category : #comparing }
MicToc >> = anItem [
	^ self species = anItem species
		and: [ self name = anItem name
				and: [ self level = anItem level and: [ self fileReference = anItem fileReference ] ] ]
]

{ #category : #adding }
MicToc >> addChildren: aToc [
	children add: aToc
]

{ #category : #converting }
MicToc >> asCTEnvironmentWithParent: aParent [
	| dictionary |
	dictionary := CTEnvironment new.
	dictionary parent: aParent.
	
	dictionary at: #name put: name.
	dictionary at: #level put: level.
	self hasFileReference ifTrue: [ 
		dictionary
			at: #href
			put: '/', (self changeFileExtension: fileReference) , '#' , self name asLowercase.
	].
	dictionary at: #hasChildren put: self children isNotEmpty.
	dictionary at: #children put: (self children collect: [ :each | 
		each asCTEnvironmentWithParent: dictionary ]).
	^ dictionary
]

{ #category : #converting }
MicToc >> asDictionary [
	| dictionary |
	dictionary := Dictionary new.
	dictionary at: #name put: name.
	dictionary at: #level put: level.
	self hasFileReference ifTrue: [ 
		dictionary
			at: #href
			put: '/', (self changeFileExtension: fileReference) , '#' , self name asLowercase.
	].
	dictionary at: #hasChildren put: self children isNotEmpty.
	dictionary at: #children put: (self children collect: [ :each | 
		each asDictionary
			at: #parent put: dictionary;
			yourself ]).
	^ dictionary
]

{ #category : #converting }
MicToc >> changeFileExtension: aPillarFile [
	^ ((aPillarFile splitOn: '.') at: 1) , '.html'
]

{ #category : #accessing }
MicToc >> children [
	^ children
]

{ #category : #accessing }
MicToc >> children: anObject [
	children := anObject
]

{ #category : #comparing }
MicToc >> compareChildren: anItem [
	^ (self children with: anItem children collect: [ :elem1 :elem2 | elem1 = elem2 ])
		inject: true
		into: [ :res :elem | res & elem ]
]

{ #category : #accessing }
MicToc >> fileReference [
	^ fileReference
]

{ #category : #accessing }
MicToc >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #testing }
MicToc >> hasFileReference [
	^ fileReference isNotNil
]

{ #category : #comparing }
MicToc >> hash [
	^ name hash + level hash + fileReference hash
]

{ #category : #comparing }
MicToc >> hashChildren [
	^ (self children collect: [ :elem | elem hash ])
		inject: 0
		into: [ :sum :value | sum + value ]
]

{ #category : #adding }
MicToc >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #accessing }
MicToc >> level [
	^ level
]

{ #category : #accessing }
MicToc >> level: anObject [
	level := anObject
]

{ #category : #accessing }
MicToc >> name [
	^ name
]

{ #category : #accessing }
MicToc >> name: anObject [
	name := anObject
]
