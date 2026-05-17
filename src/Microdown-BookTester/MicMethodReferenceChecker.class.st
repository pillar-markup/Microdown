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
	#category : 'Microdown-BookTester-Checker-MethodReferences',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-MethodReferences'
}

{ #category : 'public - name' }
MicMethodReferenceChecker class >> checkerName [ 
	^ 'MethodReferenceUsingHash'
]

{ #category : 'configuration' }
MicMethodReferenceChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'visiting - inline elements' }
MicMethodReferenceChecker >> visitText: aMicText [
	| text withHash withhoutHash |
	text := aMicText bodyString.
	text ifNil: [ ^ self ].
	withHash := text includesSubstring: '>>#'.
	withhoutHash := (RxMatcher forString: '>>[^#]') matchesIn: text.
	(withHash and: [ withhoutHash notEmpty ]) ifTrue: [ 
		results add: (MicMethodReferenceResult new 
			micElement: aMicText;
			inFile: aMicText;
			detail: text;
			yourself 
		)
		 ]
]
