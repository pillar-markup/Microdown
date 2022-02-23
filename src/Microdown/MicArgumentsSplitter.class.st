"
I am intended to provide arguments to annotations, codeblocks and environments. 

My syntax is of the following form:

- ` ` no name and no arguments
- `name` a single name, no arguments. However, this is also interpreted as name=nil 
- `key=arg[&key=arg]*`, no name, but arguments
- `name|key=arg[&key=arg]*` a single name, and arguments
"
Class {
	#name : #MicArgumentsSplitter,
	#superclass : #Object,
	#instVars : [
		'arguments',
		'defaultArg'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'instance creation' }
MicArgumentsSplitter class >> split: aString defaultArg: defArg [
	^ self split: aString defaultArg: defArg defaultValue: ''
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> split: aString defaultArg: defArg defaultValue: defValue [
	|splitter|
	splitter := self new.
	splitter	defaultArg: defArg.
	splitter arguments at: defArg put: defValue.
	^ splitter from: aString; yourself
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withStream: aStream [
	^ self withString: aStream contents.
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withString: aString [
	^ self split: aString defaultArg: #defaultArg
]

{ #category : #accessing }
MicArgumentsSplitter >> arguments [
	^ arguments
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultArg [

	^ defaultArg
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultArg: anObject [

	defaultArg := anObject
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultValue [
	^ self arguments at: #defaultArg
]

{ #category : #accessing }
MicArgumentsSplitter >> firstTag [
	self error: 'to be eliminated'.
	arguments notEmpty ifTrue: [ ^ arguments keys first asString ].
	^ ''
]

{ #category : #initialization }
MicArgumentsSplitter >> from: fullString [
	"I am the 'parser' of the argument splitter"
	| barSplit |
	fullString isEmpty ifTrue: [ ^ self ].
	(fullString intersection: '|=&') isEmpty 
		ifTrue: [ ^self setDefaultNoArguments: fullString  ].
	barSplit := fullString splitOn: $|.
	barSplit size > 1
		ifTrue: [ ^ self setDefaultAndArguments: barSplit  ].
	self setNoDefaultButArguments: fullString 
	
]

{ #category : #initialization }
MicArgumentsSplitter >> initialize [
	arguments := OrderedDictionary new.
]

{ #category : #accessing }
MicArgumentsSplitter >> name [
	self error: 'to be eliminated'.
	^ 'name'
]

{ #category : #parsing }
MicArgumentsSplitter >> setDefaultAndArguments: barSplit [
	"barSplit is two strings, first assumed to be just a name, second to be arguments"
	|defaultValue|
	defaultValue := barSplit first trim.
	self arguments at: defaultArg put: defaultValue.
	self setNoDefaultButArguments: barSplit second
]

{ #category : #parsing }
MicArgumentsSplitter >> setDefaultNoArguments: fullString [
	"fullstring is just a name (containing no arguments)
	It is interpreted as both a name, and as an argument with no value"
	|defaultValue|
	defaultValue := fullString trim.
	arguments at: defaultArg put: defaultValue
]

{ #category : #parsing }
MicArgumentsSplitter >> setNoDefaultButArguments: string [
	"string is assumed to be on the form key=value&key=value"
	| pairs |
	pairs := string splitOn: $&.
	pairs do: [ :p | |keyValue|
		keyValue := p splitOnFirst: $=.
		arguments at: keyValue first trim asSymbol put: keyValue second ]
	
]
