Class {
	#name : 'MicFrenchTypoChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-FrenchTypo',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypo'
}

{ #category : 'adding' }
MicFrenchTypoChecker >> addResultFor: anElement message: aMessage [
	results add: (MicFrenchTypoResult new 
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

{ #category : 'adding' }
MicFrenchTypoChecker >> visitCode: aMicCode [
	aMicCode caption ifNil: [ ^ self ].
	self checkString: aMicCode caption for: aMicCode.
]

{ #category : 'adding' }
MicFrenchTypoChecker >> visitText: aMicText [
	self checkString: aMicText bodyString for: aMicText. 
]
