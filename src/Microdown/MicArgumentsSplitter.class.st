"
I am intended to provide arguments to annotations, codeblocks and environments. 

My syntax is of the following form:

- ` ` defaultArg->initialValue, no other arguments. 
- `value` defaultArg->value, no otherarguments. 
- `key=arg[&key=arg]*`, defaultArg->initialValue, but arguments.
- `value|key=arg[&key=arg]*` defaultArg->value, and arguments.
"
Class {
	#name : #MicArgumentsSplitter,
	#superclass : #OrderedDictionary,
	#instVars : [
		'defaultArg',
		'initialValue'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'instance creation' }
MicArgumentsSplitter class >> split: aString [
	^ self new 
		from: aString; 
		yourself 
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> split: aString defaultArg: defArg [
	^ self new
		defaultArg: defArg;
		from: aString;
		yourself
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> split: aString defaultArg: defArg defaultValue: defValue [
	^ self new
		defaultArg: defArg;
		at: defArg put: defValue;
		initialValue: defValue;
		from: aString; 
		yourself
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withStream: aStream [
	^ self split: aStream contents.
]

{ #category : #'instance creation' }
MicArgumentsSplitter class >> withString: aString [
	^ self split: aString 
]

{ #category : #accessing }
MicArgumentsSplitter >> children [

	^ #()
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultArg [

	^ defaultArg ifNil: [ defaultArg := #defaultArg ]
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultArg: anObject [

	defaultArg := anObject
]

{ #category : #accessing }
MicArgumentsSplitter >> defaultValue [
	^ self at: defaultArg ifAbsent: [ initialValue  ]
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

{ #category : #testing }
MicArgumentsSplitter >> hasNonDefaultArguments [
	"has changed #defaultArg or has other keys"
	^ self hasNonDefaultValue or: [ (self keys copyWithout: self defaultArg ) notEmpty  ]
		
]

{ #category : #testing }
MicArgumentsSplitter >> hasNonDefaultValue [
	"return true if the default arg was given a value"
	^ self defaultValue notNil and: [ self defaultValue ~= initialValue  ]
]

{ #category : #accessing }
MicArgumentsSplitter >> initialValue: anObject [

	initialValue := anObject
]

{ #category : #copying }
MicArgumentsSplitter >> justTheArguments [
	^ self copy 
		removeKey: defaultArg ifAbsent: [ ]; 
		yourself 
]

{ #category : #printing }
MicArgumentsSplitter >> printOn: aStream [
	|argKeys|
	self hasNonDefaultValue 
		ifTrue:[
			aStream nextPutAll: self defaultValue.
			argKeys := self keys copyWithout: self defaultArg.
			argKeys ifNotEmpty: [aStream nextPut: $|]]
		ifFalse: [argKeys := self keys].
	aStream nextPutAll: ((argKeys collect: [:k| k,'=',(self at:k)]) joinUsing: '&')
]

{ #category : #printing }
MicArgumentsSplitter >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #parsing }
MicArgumentsSplitter >> setDefaultAndArguments: barSplit [
	"barSplit is two strings, first assumed to be just a value, second to be arguments"
	|value|
	value := barSplit first trim.
	self at: self defaultArg put: value.
	self setNoDefaultButArguments: barSplit second
]

{ #category : #parsing }
MicArgumentsSplitter >> setDefaultNoArguments: fullString [
	"fullstring is just a name (containing no arguments)
	It is interpreted as both a name, and as an argument with no value"
	|value|
	value := fullString trim.
	self at: self defaultArg put: value
]

{ #category : #parsing }
MicArgumentsSplitter >> setNoDefaultButArguments: string [
	"string is assumed to be on the form key=value&key=value"
	| pairs |
	pairs := string splitOn: $&.
	pairs do: [ :p | |keyValue|
		keyValue := p splitOnFirst: $=.
		self at: keyValue first trim asSymbol put: keyValue second ]
	
]

{ #category : #copying }
MicArgumentsSplitter >> withoutDefaultValue [
	"remove the defaultArg if no new value was assigned to it"
	^ self hasNonDefaultValue 
		ifTrue: [ ^ self ]
		ifFalse: [ self copy 
			removeKey: defaultArg ifAbsent: [ ]; 
			yourself ]
]
