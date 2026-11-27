"
I check that method references are consistent within a document.
Either all references use the # symbol or none of them do.

Example of consistent references (always with #):

```
SpPresenter>>#methodOne
SpPresenter>>#methodTow
```

Example of consistent references (always without #):

```
SpPresenter>>methodOne
SpPresenter>>methodTwo
```

Example of consistent references (flagged as error):

```
SpPresenter>>#methodOne
SpPresenter>>methodTwo
```
"
Class {
	#name : 'MicMethodReferenceChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'requireHash'
	],
	#category : 'Microdown-BookTester-Checker-MethodReferences',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-MethodReferences'
}

{ #category : 'public - name' }
MicMethodReferenceChecker class >> checkerName [ 
	^ 'MethodReferenceUsingHash'
]

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> initialize [
	super initialize.
	requireHash := true
]

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> requireHash [
	^ requireHash
]

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> requireHash: aBoolean [
	requireHash := aBoolean
]

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> visitText: aMicText [
	| text hasHash hasNoHash hasError |
	text := aMicText bodyString.
	text ifNil: [ ^ self ].
	
	hasHash := text includesSubstring: '>>#'.
	hasNoHash := (RxMatcher forString: '>>[^#]') matchesIn: text.
	
	hasError := self requireHash 
		ifTrue: [ hasNoHash notEmpty ] 
		ifFalse: [ hasHash ].
		
	hasError ifTrue: [ 
		results add: (MicMethodReferenceResult new 
			micElement: aMicText;
			inFile: aMicText;
			detail: text;
			yourself
		)
	]
]
