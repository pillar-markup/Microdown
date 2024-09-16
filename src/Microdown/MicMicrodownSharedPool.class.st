"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : 'MicMicrodownSharedPool',
	#superclass : 'SharedPool',
	#classVars : [
		'AnchorMarkup',
		'AnchorReferenceCloserMarkup',
		'AnchorReferenceOpenerMarkup',
		'AnnotatedParagraphBackwardCompatibleMarkup',
		'AnnotatedParagraphClosingMarkup',
		'AnnotatedParagraphOpeningMarkup',
		'AnnotationCloserMarkup',
		'AnnotationOpenerMarkup',
		'ArgumentListDelimiter',
		'ArgumentListEqualsDelimiter',
		'ArgumentListOfFigureStartDelimiter',
		'ArgumentListStartDelimiter',
		'BoldMarkup',
		'CodeblockMarkup',
		'CommentedLineMarkup',
		'Delimiters',
		'EnvironmentClosingBlockMarkup',
		'EnvironmentOpeningBlockMarkup',
		'FigureNameOpenerMarkup',
		'FixiousTextDelimiter',
		'HeaderMarkup',
		'HorizontalLineMarkup',
		'ItalicMarkup',
		'LinkNameCloserMarkup',
		'LinkNameOpenerMarkup',
		'MathClosingBlockMarkup',
		'MathMarkup',
		'MathOpeningBlockMarkup',
		'MetaDataClosingBlockMarkup',
		'MetaDataOpeningBlockMarkup',
		'MonospaceMarkup',
		'NameCloserUrlOpener',
		'OrderedListSemiMarkup',
		'PreformattedMarkup',
		'RawCloserMarkup',
		'RawOpenerMarkup',
		'StrikeMarkup',
		'TableCellMarkup',
		'URLCloserMarkup',
		'URLOpenerMarkup',
		'UnorderedListMarkup',
		'UnorderedListPlusMarkup',
		'UnorderedListStarMarkup'
	],
	#category : 'Microdown-Parser',
	#package : 'Microdown',
	#tag : 'Parser'
}

{ #category : 'class initialization' }
MicMicrodownSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'.
	AnnotatedParagraphBackwardCompatibleMarkup := '!!'.
	"we keep it to avoid breaking existing text but we should favor one that is compatible with github eg the next one"
	AnnotatedParagraphOpeningMarkup := '>[!'.
	AnnotatedParagraphClosingMarkup := ']'.
	CodeblockMarkup := '```'.
	CommentedLineMarkup := '%'.
	EnvironmentClosingBlockMarkup := '!>'.
	EnvironmentOpeningBlockMarkup := '<!'.
	HeaderMarkup := '#'.
	HorizontalLineMarkup	:= '***'.
	MathClosingBlockMarkup := '$$'.
	MathOpeningBlockMarkup := '$$'.	
	MetaDataClosingBlockMarkup := '}'.
	MetaDataOpeningBlockMarkup := '{'.
	OrderedListSemiMarkup := '. '.
	PreformattedMarkup := '> '.
	TableCellMarkup	:= '|'.
	UnorderedListMarkup := '- '.
   UnorderedListPlusMarkup := '+ '.
	UnorderedListStarMarkup := '* '.

	ArgumentListDelimiter := '&'.
	ArgumentListEqualsDelimiter := '='.
	ArgumentListOfFigureStartDelimiter := '?'.
	ArgumentListStartDelimiter := '|'.
	
	
	AnchorReferenceCloserMarkup := '@*'.
	AnchorReferenceOpenerMarkup := '*@'. 
	
	AnnotationCloserMarkup := '!}'. 
	AnnotationOpenerMarkup := '{!'.

	BoldMarkup := '**'. 
	FigureNameOpenerMarkup := '!['. 
	ItalicMarkup := '_'. 
	LinkNameCloserMarkup := ']'. 
	LinkNameOpenerMarkup := '['.  
	MathMarkup := '$'. 
	MonospaceMarkup := '`'. 
	RawCloserMarkup := '}}'. 
	RawOpenerMarkup := '{{'. 
	StrikeMarkup := '~'. 
	URLCloserMarkup := ')'. 
	URLOpenerMarkup := '('.
	NameCloserUrlOpener := ']('.
	FixiousTextDelimiter := 0 asCharacter asString.

	Delimiters := { AnchorReferenceCloserMarkup . 
	AnchorReferenceOpenerMarkup .
	AnnotationCloserMarkup .
	AnnotationOpenerMarkup .
	BoldMarkup .
	FigureNameOpenerMarkup .  
	ItalicMarkup .
	LinkNameCloserMarkup .  
	LinkNameOpenerMarkup .  
	MathMarkup .
	NameCloserUrlOpener.
	MonospaceMarkup .  
	RawCloserMarkup . 
	RawOpenerMarkup .
	StrikeMarkup . 
	URLCloserMarkup . 
	URLOpenerMarkup} asSet

	
	
	
	
	
	
	
	







]
