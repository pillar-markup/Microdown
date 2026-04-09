"
I check that punctuation follows French typography: in French there is a space before diacritics (:;?!) and there is space after diacrittics and (.,).

```
N'est pas superbe que Microdown puisse trouver de telles erreurrs ? Si bien sur.
```
"
Class {
	#name : 'MicFrenchTypoChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-FrenchTypography',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypography'
}

{ #category : 'public - name' }
MicFrenchTypoChecker class >> checkerName [ 
	
	^ 'FrenchTypography'
]

{ #category : 'configuration' }
MicFrenchTypoChecker class >> mutuallyExclusiveWith [ 
	^ #('EnglishTypography')
]

{ #category : 'adding' }
MicFrenchTypoChecker >> addResultFor: anElement message: aMessage [
	results add: (MicFrenchTypographyResult new 
		micElement: anElement;
		inFile: anElement fromFile;
		detail: aMessage;
		yourself 
	) 
]

{ #category : 'adding' }
MicFrenchTypoChecker >> checkString: aString for: anElement [
	| checks |
	aString ifNil: [ ^ self ].
	checks := { 
		'[^ ]\:' -> 'Il devrait y avoir un espace avant :'.
		'[^ ]\;' -> 'Il devrait y avoir un espace avant ;'.
		'[^ ]\?' -> 'Il devrait y avoir un espace avant ?'.
		'[^ ]\!' -> 'Il devrait y avoir un espace avant !'.
		' \,' -> 'Il ne devrait pas y avoir d''espace avant la virgule'.
		',[^ ]' -> 'Il devrait y avoir un espace après la virgule'.
		'\.[^ ]' -> 'Il ne devrait pas y avoir d''espace après le point'.
	 }.
	checks do: [ :pair |
		| matcher |
		matcher := RxMatcher forString: pair key.
		(matcher matchesIn: aString) notEmpty ifTrue: [ 
			self addResultFor: anElement message: pair value 
			 ]
		 ]
]

{ #category : 'configuration' }
MicFrenchTypoChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'as yet unclassified' }
MicFrenchTypoChecker >> resultHeaderStrings [
    ^ #('French Typography')
]

{ #category : 'adding' }
MicFrenchTypoChecker >> visitCode: aMicCode [
	aMicCode caption ifNil: [ ^ self ].
	self checkString: aMicCode caption for: aMicCode.
]

{ #category : 'adding' }
MicFrenchTypoChecker >> visitText: aMicText [
	self checkString: aMicText bodyString for: aMicText. 
]
