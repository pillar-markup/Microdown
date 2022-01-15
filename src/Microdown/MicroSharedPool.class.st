"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : #MicroSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'AnchorMarkup',
		'AnchorReferenceCloserDelimiter',
		'AnchorReferenceOpenerDelimiter',
		'AnnotatedParagraphMarkup',
		'AnnotationCloserDelimiter',
		'AnnotationOpenerDelimiter',
		'ArgumentListDelimiter',
		'ArgumentListEqualsDelimiter',
		'ArgumentListOfFigureStartDelimiter',
		'ArgumentListStartDelimiter',
		'BoldDelimiter',
		'CodeblockMarkup',
		'CommentedLineMarkup',
		'EnvironmentClosingBlockMarkup',
		'EnvironmentOpeningBlockMarkup',
		'FigureNameOpenerDelimiter',
		'HeaderMarkup',
		'HorizontalLineMarkup',
		'ItalicDelimiter',
		'LinkNameCloserDelimiter',
		'LinkNameOpenerDelimiter',
		'MathClosingBlockMarkup',
		'MathDelimiter',
		'MathOpeningBlockMarkup',
		'MetaDataClosingBlockMarkup',
		'MetaDataOpeningBlockMarkup',
		'MonospaceDelimiter',
		'OrderedListSemiMarkup',
		'PreformattedMarkup',
		'RawCloserDelimiter',
		'RawOpenerDelimiter',
		'StrikeDelimiter',
		'TableCellMarkup',
		'URLCloserDelimiter',
		'URLOpenerDelimiter',
		'UnorderedListMarkup',
		'UnorderedListPlusMarkup',
		'UnorderedListStarMarkup'
	],
	#category : #'Microdown-Parser'
}

{ #category : #initialization }
MicroSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'.
	AnnotatedParagraphMarkup := '!!'.
	CodeblockMarkup := '```'.
	CommentedLineMarkup := '%'.
	EnvironmentClosingBlockMarkup := '?>'.
	EnvironmentOpeningBlockMarkup := '<?'.
	HeaderMarkup := '#'.
	HorizontalLineMarkup	:= '***'.
	MathClosingBlockMarkup := '&'.
	MathOpeningBlockMarkup := '&'.	
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
	
	
	AnchorReferenceCloserDelimiter := '@*'.
	AnchorReferenceOpenerDelimiter := '*@'. 
	
	AnnotationCloserDelimiter := '}?'. 
	AnnotationOpenerDelimiter := '?{'.

	BoldDelimiter := '**'. 
	FigureNameOpenerDelimiter := '!['. 
	ItalicDelimiter := '_'. 
	LinkNameCloserDelimiter := ']'. 
	LinkNameOpenerDelimiter := '['.  
	MathDelimiter := '$'. 
	MonospaceDelimiter := '`'. 
	RawCloserDelimiter := '}}'. 
	RawOpenerDelimiter := '{{'. 
	StrikeDelimiter := '~'. 
	URLCloserDelimiter := ')'. 
	URLOpenerDelimiter := '('. 

	
	
	
	
	
	
	
	
	







]
