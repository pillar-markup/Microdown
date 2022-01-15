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
		'ArgumentListDelimiter',
		'ArgumentListEqualsDelimiter',
		'ArgumentListOfFigureStartDelimiter',
		'ArgumentListStartDelimiter',
		'CodeblockMarkup',
		'CommentedLineMarkup',
		'EnvironmentClosingBlockMarkup',
		'EnvironmentOpeningBlockMarkup',
		'HeaderMarkup',
		'HorizontalLineMarkup',
		'MathClosingBlockMarkup',
		'MathOpeningBlockMarkup',
		'MetaDataClosingBlockMarkup',
		'MetaDataOpeningBlockMarkup',
		'OrderedListSemiMarkup',
		'PreformattedMarkup',
		'TableCellMarkup',
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
"	
	AnnotationCloserDelimiter := nil. 
	AnnotationOpenerDelimiter := nil.
	BoldDelimiter := nil. 
	FigureNameOpenerDelimiter := nil. 
	ItalicDelimiter := nil. 
	LinkNameCloserDelimiter := nil. 
	LinkNameOpenerDelimiter := nil.  
	MathDelimiter  := nil. 
	MonospaceDelimiter := nil. 
	RawCloserDelimiter := nil. 
	RawOpenerDelimiter := nil. 
	StrikeDelimiter := nil. 
	URLCloserDelimiter := nil. 
	URLOpenerDelimiter := nil. 
"
	
	
	
	
	
	
	
	
	







]
