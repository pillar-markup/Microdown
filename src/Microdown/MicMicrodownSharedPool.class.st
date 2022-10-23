"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : #MicMicrodownSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'AnchorMarkup',
		'AnchorReferenceCloserMarkup',
		'AnchorReferenceOpenerMarkup',
		'AnnotatedParagraphMarkup',
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
	#category : #'Microdown-Parser'
}

{ #category : #'class initialization' }
MicMicrodownSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'.
	AnnotatedParagraphMarkup := '!!'.
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
