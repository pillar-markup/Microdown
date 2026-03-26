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
		'[^ ]\:' -> 'There should be a space before :'.
		'[^ ]\;' -> 'There should be a space before ;'.
		'[^ ]\?' -> 'There should be a space before ?'.
		'[^ ]\!' -> 'There should be a space before !'.
		' \,' -> 'There should be no space before ,'.
		',[^ ]' -> 'There should be a space after ,'.
		'\.[^ ]' -> 'There should be no space after .'.
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

{ #category : 'adding' }
MicFrenchTypoChecker >> visitCode: aMicCode [
	aMicCode caption ifNil: [ ^ self ].
	self checkString: aMicCode caption for: aMicCode.
]

{ #category : 'adding' }
MicFrenchTypoChecker >> visitText: aMicText [
	self checkString: aMicText bodyString for: aMicText. 
]
