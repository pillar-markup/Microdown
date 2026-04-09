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

{ #category : 'configuration help' }
MicEnglishTypographyChecker class >> explanationForConfiguration [ 
	^ 'I check that punctuation follows English typography rules. No space before : ; ? ! and space after : , ; ? !
	URLs (http:// and https://) are ignored.
	No configuration needed.
	In pillar.conf add:
		"onlyCheckers" : [ "EnglishTypography" ]'
]

{ #category : 'configuration' }
MicEnglishTypographyChecker class >> mutuallyExclusiveWith [ 
	^ #('FrenchTypography')
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
	| checks cleanString |
	aString ifNil: [ ^self ].
	cleanString := aString copyReplaceAll: (String with: Character lf) with: ' '.
	cleanString := cleanString copyReplaceAll: (String with: Character cr) with: ' '. 
checks := {
		' \:' -> 'There is a space before :'.
		' \,' -> 'There is a space before ,'.
		'\:[^ /]' -> 'There is no space after :'.
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
		(matcher matchesIn: cleanString) notEmpty ifTrue: [
			self addResultFor: anElement message: message
		]
	].
]

{ #category : 'as yet unclassified' }
MicEnglishTypographyChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'as yet unclassified' }
MicEnglishTypographyChecker >> resultHeaderStrings [
    ^ #('English Typography violations')
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
