"
I check that punctuation follows English typography: in English there is no space before diacritics (:;?!) and there is space after diacrittics and (.,). I pay attention that a diacritics can be the last character of a line: in this case I do not report errors.

The following paragraph does not contain mistakes.

Is it not great that Microdown rule checkers can spot such mistakes? Indeed, this is great.

"
Class {
	#name : 'MicEnglishTypographyChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-EnglishTypography',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypography'
}

{ #category : 'public - name' }
MicEnglishTypographyChecker class >> checkerName [ 
	
	^ 'EnglishTypography'
]

{ #category : 'adding' }
MicEnglishTypographyChecker >> addResultFor: anElement message: aMessage [
	results add: (MicEnglishTypographyResult new 
		micElement: anElement;
		inFile: anElement fromFile;
		detail: aMessage;
		yourself
		).
]

{ #category : 'adding' }
MicEnglishTypographyChecker >> checkString: aString for: anElement [
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
MicEnglishTypographyChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'adding' }
MicEnglishTypographyChecker >> visitCode: aCodeBlock [

	aCodeBlock caption ifNil: [ ^self ].
	self checkString: aCodeBlock caption for: aCodeBlock.
]

{ #category : 'adding' }
MicEnglishTypographyChecker >> visitMonospace: aCodeBlock [
	^ self
]

{ #category : 'adding' }
MicEnglishTypographyChecker >> visitText: aText [

	self checkString: aText bodyString for: aText. 

]
