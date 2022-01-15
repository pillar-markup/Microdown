"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : #MicroSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'AnchorMarkup',
		'AnnotatedParagraphMarkup',
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
	PreformattedMarkup := '> '.
	TableCellMarkup	:= '|'.
	UnorderedListMarkup := '- '.
   UnorderedListPlusMarkup := '+ '.
	UnorderedListStarMarkup := '* '.


]
