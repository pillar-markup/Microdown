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
		'HTMLTags',
		'HeaderMarkup',
		'HorizontalLineMarkup',
		'InlineSpace',
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
		'ThreeLettersHTMLTags',
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
	"Pay attention that br is not in this list!"
		
	^ #('!--' 'a' 'abbr' 'address' 'area' 'article' 'aside' 'audio' 'b' 'base' 'bdi' 'bdo' 'blockquote' 'body' 'button' 'canvas' 'caption' 'cite' 'code' 'col' 'colgroup' 'data' 'datalist' 'dd' 'del' 'details' 'dfn' 'dialog' 'div' 'dl' 'dt' 'em' 'embed' 'fieldset' 'figcaption' 'figure' 'footer' 'form' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' 'head' 'header' 'hgroup' 'hr' 'html' 'i' 'iframe' 'img' 'input' 'ins' 'kbd' 'label' 'legend' 'li' 'link' 'main' 'map' 'mark' 'menu' 'meta' 'meter' 'nav' 'noscript' 'object' 'ol' 'optgroup' 'option' 'output' 'p' 'param' 'picture' 'pre' 'progress' 'q' 'rb' 'rp' 'rt' 'rtc' 'ruby' 's' 'samp' 'script' 'section' 'select' 'slot' 'small' 'source' 'span' 'strong' 'style' 'sub' 'summary' 'sup' 'table' 'tbody' 'td' 'template' 'textarea' 'tfoot' 'th' 'thead' 'time' 'title' 'tr' 'track' 'u' 'ul' 'var' 'video' 'wbr')
]

{ #category : 'class initialization' }
MicSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'.
	
	AnnotatedParagraphBackwardCompatibleMarkup := '!!'.
	"we keep it to avoid breaking existing text but we should favor one that is compatible with github eg the next one"
	AnnotatedParagraphOpeningMarkup := '>[!'.
	AnnotatedParagraphClosingMarkup := ']'.
	PreformattedMarkup := '> '.

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
	
	TableCellMarkup	:= '|'.
	UnorderedListMarkup := '- '.
   UnorderedListPlusMarkup := '+ '.
	UnorderedListStarMarkup := '* '.

	self initializeRawParagraph.

"Argument list"

	ArgumentListDelimiter := '&'.
	ArgumentListEqualsDelimiter := '='.
	ArgumentListOfFigureStartDelimiter := '?'.
	ArgumentListStartDelimiter := '|'.

"In paragraph!"
		
	AnchorReferenceCloserMarkup := '@*'.
	AnchorReferenceOpenerMarkup := '*@'. 
	
	AnnotationCloserMarkup := '!}'. 
	AnnotationOpenerMarkup := '{!'.

	InlineSpace := '<br>'.
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
	InlineSpace .
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
	"self initializeRawParagraph"
	
	HTMLTags := self htmlTags.
	ThreeLettersHTMLTags := self threeLetterhtmlTags 
]

{ #category : 'class initialization' }
MicSharedPool class >> threeLetterhtmlTags [
	"self threeLetterhtmlTags  #('!--' 'a' 'abb' 'add' 'are' 'art' 'asi' 'aud' 'b' 'bas' 'bdi' 'bdo' 'blo' 'bod' 'br' 'but' 'can' 'cap' 'cit' 'cod' 'col' 'col' 'dat' 'dat' 'dd' 'del' 'det' 'dfn' 'dia' 'div' 'dl' 'dt' 'em' 'emb' 'fie' 'fig' 'fig' 'foo' 'for' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' 'hea' 'hea' 'hgr' 'hr' 'htm' 'i' 'ifr' 'img' 'inp' 'ins' 'kbd' 'lab' 'leg' 'li' 'lin' 'mai' 'map' 'mar' 'men' 'met' 'met' 'nav' 'nos' 'obj' 'ol' 'opt' 'opt' 'out' 'p' 'par' 'pic' 'pre' 'pro' 'q' 'rb' 'rp' 'rt' 'rtc' 'rub' 's' 'sam' 'scr' 'sec' 'sel' 'slo' 'sma' 'sou' 'spa' 'str' 'sty' 'sub' 'sum' 'sup' 'tab' 'tbo' 'td' 'tem' 'tex' 'tfo' 'th' 'the' 'tim' 'tit' 'tr' 'tra' 'u' 'ul' 'var' 'vid' 'wbr')"	
	"self threeLetterhtmlTags size = self htmlTags size is true so with 3 letter we can distinguish uniquely tags."	
		
	^ self htmlTags collect: [ :each | each truncateTo: 3 ]
]
