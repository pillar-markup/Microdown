"
I am intended to provide arguments to annotations, codeblocks and environments. 

My syntax is of the following form:

- ` ` no name and no arguments
- `name` a single name, no arguments
- `key=arg[&key=arg]*`, no name, but arguments
- `name|key=arg[&key=arg]*` a single name, and arguments
"
Class {
	#name : #MicArgumentsSplitter,
	#superclass : #Object,
	#instVars : [
		'arguments',
		'name'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withStream: aStream [
	^ self withString: aStream contents.
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withString: aString [
	^ self new from: aString; yourself 
]

{ #category : #accessing }
MicArgumentsSplitter >> arguments [
	^ arguments
]

{ #category : #accessing }
MicArgumentsSplitter >> firstTag [
	name ifNotNil: [ ^name ].
	arguments notEmpty ifTrue: [ ^arguments keys first asString ].
	^''
]

{ #category : #initialization }
MicArgumentsSplitter >> from: fullString [
	
	| barSplit |
	arguments := OrderedDictionary new.
	fullString isEmpty ifTrue: [ ^ self ].
	(fullString intersection: '|=&') isEmpty 
		ifTrue: [ ^self setNameNoArguments: fullString  ].
	barSplit := fullString splitOn: $|.
	barSplit size > 1
		ifTrue: [ ^ self setNameAndArguments: barSplit  ].
	self setNoNameButArguments: fullString 
	
]

{ #category : #accessing }
MicArgumentsSplitter >> name [
	^ name
]

{ #category : #parsing }
MicArgumentsSplitter >> setNameAndArguments: barSplit [
	"barSplit is two strings, first assumed to be just a name, second to be arguments"
	name := barSplit first trim.
	self setNoNameButArguments: barSplit second
]

{ #category : #parsing }
MicArgumentsSplitter >> setNameNoArguments: fullString [
	"fullstring is just a name (containing no arguments)
	It is interpreted as both a name, and as an argument with no value
	"
	name := fullString trim.
	arguments at: name asSymbol put: nil
]

{ #category : #parsing }
MicArgumentsSplitter >> setNoNameButArguments: string [
	"string is assumed to be on the form key=value&key=value"
	| pairs |
	pairs := string splitOn: $&.
	pairs do: [ :p | |keyValue|
		keyValue := p splitOnFirst: $=.
		arguments at: keyValue first trim asSymbol put: keyValue second.
		 ]
	
]
