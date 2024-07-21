"
I am a superclass for the inline delimiters.
I am an administrer class which gathers delimiters from my subclasses. See the method `MicInlineDelimiter>>#all` and `initializeDelimiters`.

I store the actual delimiters in the class variable `DelimiterDictionary`.
My class side method `initializeDelimiters` gathers delimiters from my subclasses.

"
Class {
	#name : 'MicInlineDelimiter',
	#superclass : 'Object',
	#classVars : [
		'DelimiterDictionary'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'accessing' }
MicInlineDelimiter class >> all [
	DelimiterDictionary ifNil: [ self initializeDelimiters ].
	^ DelimiterDictionary values
]

{ #category : 'private utilities' }
MicInlineDelimiter class >> allRegex [
	^ ((MicInlineDelimiter all collect: [ :each | each markupAsRegex]) joinUsing: '|') asRegex
	
]

{ #category : 'accessing' }
MicInlineDelimiter class >> at: markup [
	"return delimiter at markup, or nil"
	^ DelimiterDictionary at: markup ifAbsent: [ nil ]
]

{ #category : 'initialization' }
MicInlineDelimiter class >> initialize [
	<script>
	DelimiterDictionary := nil
]

{ #category : 'initialization' }
MicInlineDelimiter class >> initializeDelimiters [
	self = MicInlineDelimiter ifFalse: [ ^ self ].
	DelimiterDictionary := Dictionary new.
	self allSubclasses do: [ :class | class initializeDelimiters ]
]

{ #category : 'compiling' }
MicInlineDelimiter class >> noteCompilationOf: aSelector meta: isMeta [
	"I reset when any method is recompiled"
	self initialize
]

{ #category : 'private utilities' }
MicInlineDelimiter class >> regexNot: markup [
	"return a regular expression (string), which is recognizing anything but markup"
	| str prefix|
	str := WriteStream on: ''.
	str nextPut: $(.
	prefix := ''.
	1 to: markup size do: [ :idx |
		str nextPutAll: prefix; nextPut: $[;nextPut: $^; nextPut: (markup at: idx); nextPut: $].
		prefix := '|', (markup copyFrom: 1 to: idx) escapeAll.
		 ].
	str nextPut: $);nextPut: $*.
	^ str contents
]

{ #category : 'adding' }
MicInlineDelimiter >> addMe [
	"add me to the dictionary in my class"
	DelimiterDictionary at: self markup put: self
]

{ #category : 'accessing' }
MicInlineDelimiter >> blockClass [
	self subclassResponsibility
]

{ #category : 'accessing' }
MicInlineDelimiter >> closer [
	self subclassResponsibility
]

{ #category : 'testing' }
MicInlineDelimiter >> isEvaluated [
	"I am an opener whose resultering block will need further inline parsing"
	^ self isOpener and: [self blockClass isEvaluated ]
]

{ #category : 'testing' }
MicInlineDelimiter >> isOpener [
	^ self closer isNotNil or: [ self markup = self closer ]
]

{ #category : 'testing' }
MicInlineDelimiter >> isRawkind [
	"I am an opener whose resulting nodes body is not further parsed"
	^ self isOpener and: [ self blockClass isEvaluated not ]
]

{ #category : 'accessing' }
MicInlineDelimiter >> markup [
	self subclassResponsibility
]

{ #category : 'accessing' }
MicInlineDelimiter >> markupAsRegex [
	self subclassResponsibility
]
