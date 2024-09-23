"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : 'MicSharedPool',
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
MicSharedPool class >> htmlTags [
		
	^ #('!--' 'a' 'abbr' 'address' 'area' 'article' 'aside' 'audio' 'b' 'base' 'bdi' 'bdo' 'blockquote' 'body' 'br' 'button' 'canvas' 'caption' 'cite' 'code' 'col' 'colgroup' 'data' 'datalist' 'dd' 'del' 'details' 'dfn' 'dialog' 'div' 'dl' 'dt' 'em' 'embed' 'fieldset' 'figcaption' 'figure' 'footer' 'form' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' 'head' 'header' 'hgroup' 'hr' 'html' 'i' 'iframe' 'img' 'input' 'ins' 'kbd' 'label' 'legend' 'li' 'link' 'main' 'map' 'mark' 'menu' 'meta' 'meter' 'nav' 'noscript' 'object' 'ol' 'optgroup' 'option' 'output' 'p' 'param' 'picture' 'pre' 'progress' 'q' 'rb' 'rp' 'rt' 'rtc' 'ruby' 's' 'samp' 'script' 'section' 'select' 'slot' 'small' 'source' 'span' 'strong' 'style' 'sub' 'summary' 'sup' 'table' 'tbody' 'td' 'template' 'textarea' 'tfoot' 'th' 'thead' 'time' 'title' 'tr' 'track' 'u' 'ul' 'var' 'video' 'wbr')
]

{ #category : 'class initialization' }
MicSharedPool class >> initialize [
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

{ #category : 'class initialization' }
MicSharedPool class >> initializeRawParagraph [
	"self initialize"
	
	
]
