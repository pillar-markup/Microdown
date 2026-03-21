Class {
	#name : 'MicEnglishTypoChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-EnglishTypographic',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypographic'
}

{ #category : 'adding' }
MicEnglishTypoChecker >> addResultFor: anElement message: aMessage [
	results add: (MicSpaceBeforeDiacriticsResult new 
		micElement: anElement;
		inFile: anElement fromFile;
		detail: aMessage;
		yourself
		).
]

{ #category : 'adding' }
MicEnglishTypoChecker >> checkString: aString for: anElement [
	| checks |
	aString ifNil: [ ^self ].
checks := {
		' \:' -> 'There is a space before :'.
		' \,' -> 'There is a space before ,'.
		'\:[^ ]' -> 'There is no space after :'.
		',[^ ]' -> 'There is no space after ,'.
		' \;' -> 'There is a space before ;'.
		'\;[^ ]' -> 'There is no space after ;'.
		' \?' -> 'There is a space before ?'.
		'\?[^ ]' -> 'There is no space after ?'.
		' \!' -> 'There is a space before !'.
		'\![^ ]' -> 'There is no space after !'
	}.

	checks do: [ :pair |
		| pattern message matcher |
		pattern := pair key.
		message := pair value.

		matcher := RxMatcher forString: pattern.
		(matcher matchesIn: aString) notEmpty ifTrue: [
			self addResultFor: anElement message: message
		]
	].
]

{ #category : 'as yet unclassified' }
MicEnglishTypoChecker >> checkerName [ 
	^ 'EnglishTypographic'
]

{ #category : 'as yet unclassified' }
MicEnglishTypoChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'adding' }
MicEnglishTypoChecker >> visitCode: aCodeBlock [

	aCodeBlock caption ifNil: [ ^self ].
	self checkString: aCodeBlock caption for: aCodeBlock.
]

{ #category : 'adding' }
MicEnglishTypoChecker >> visitMonospace: aCodeBlock [
	^ self
]

{ #category : 'adding' }
MicEnglishTypoChecker >> visitText: aText [

	self checkString: aText bodyString for: aText. 

]
