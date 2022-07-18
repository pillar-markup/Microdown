"
Provides a presenter to configure common export HTML options, for example:

- The document type a.k.a DOCTYPE
- Include CSS in header.
- Set links to open to a new web page.


"
Class {
	#name : #MicHTMLStylerHTMLOptionsPresenter,
	#superclass : #MicHTMLStylerAbstractPresenter,
	#instVars : [
		'doctypeListPresenter',
		'embeedCheckboxPresenter',
		'linksOpenNewPage',
		'encodingOptionsListPresenter',
		'languageOptionsPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicHTMLStylerHTMLOptionsPresenter >> charSet [

	^ encodingOptionsListPresenter selectedItem.
]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> defaultLanguageSelection [

	^ (ISOLanguageDefinition iso2LanguageTable associations 
		select: [ : assoc | assoc key = 'en' ] 
		thenCollect: [ : assoc | assoc key , ' - ' , assoc value language ]) anyOne
]

{ #category : #layout }
MicHTMLStylerHTMLOptionsPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;		
			add: 'Document Type';
			add: doctypeListPresenter;
			nextRow;
			add: 'Encoding';
			add: encodingOptionsListPresenter;
			nextRow;
			add: 'Language';
			add: languageOptionsPresenter;
			nextRow;
			add: 'Embeed CSS';
			add: embeedCheckboxPresenter;
			nextRow;
			add: 'Links open a new page';
			add: linksOpenNewPage ]
]

{ #category : #private }
MicHTMLStylerHTMLOptionsPresenter >> docTypeOptionNames [

	^ self docTypeOptions keys
]

{ #category : #private }
MicHTMLStylerHTMLOptionsPresenter >> docTypeOptions [

	^ OrderedDictionary new
		at: 'HTML 5' put: '<!DOCTYPE html>';	
		at: 'XHTML 1.1' put: '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">';
		at: 'XHTML 1.0 Transitional' put: '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'; 
		at: 'XHTML 1.0 Frameset' put: '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">';
		at: 'XHTML 1.0 Strict' put: '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';
		at: 'HTML 4.01 Transitional' put: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">';
		at: 'HTML 4.01 Frameset' put: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
"http://www.w3.org/TR/html4/frameset.dtd">';
		at: 'HTML 4.01 Strict' put: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">';
		at: 'HTML 3.2' put: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">'; 
		at: 'Compact HTML 2.0' put: '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0 Strict Level 2//EN">';
		yourself
]

{ #category : #layout }
MicHTMLStylerHTMLOptionsPresenter >> documentType [
	"Answer a <String> describing the selected HTML document type"
	
	^ doctypeListPresenter selectedItem
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsPresenter >> embeedCheckboxPresenter [

	^ embeedCheckboxPresenter
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsPresenter >> enableEmbeedCss [

	self embeedCheckboxPresenter enabled: true.
]

{ #category : #private }
MicHTMLStylerHTMLOptionsPresenter >> encodingOptions [

	^ #(
		'UTF-8'
		'UTF-16'
		'UTF-32'
		'ASCII'
		'ISO 8859-1'
		'ISO 8859-2'
		'ISO 8859-3'
		'ISO 8859-4'
		'ISO 8859-5'
		'ISO 8859-6'
		'ISO 8859-7'
		'ISO 8859-8'
		'ISO 8859-9'
		'ISO 8859-10'
		'ISO 8859-11'
		'ISO 8859-13'
		'ISO 8859-14' 
		'ISO 8859-15'
		'ISO 8859-16'
		'Windows-1250'
		'Windows-1251'
		'Windows-1252'
		'Windows-1253'
		'Windows-1254'
		'Windows-1255'
		'Windows-1256'
		'Windows-1257'
		'Windows-1258'
		)
]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializeDocTypeListPresenter [

	doctypeListPresenter := self newDropList
		help: 'Select the document type to be generated';
		items: self docTypeOptionNames;
		whenSelectedItemChangedDo: [ : selection |
			self micHtmlDocument documentType: (self docTypeOptions at: selection).
			self styler updateHtmlSourcePresenter ]
		yourself.		


]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializeEmbeedingCheckPresenter [

	embeedCheckboxPresenter := self newCheckBox
		state: false;
		enabled: false;
		whenChangedDo: [ 
			self micHtmlDocument embeedCss.
			self styler updateHtmlSourcePresenter ]
		yourself.
]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializeEncodingOptionsListPresenter [

	encodingOptionsListPresenter := self newDropList 
		help: 'Select the document encoding';
		items: self encodingOptions;
		whenSelectedItemChangedDo: [ : selection | 
			self micHtmlDocument charSet: selection.
			self styler updateHtmlSourcePresenter ];
		yourself.

]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializeLanguageOptionsListPresenter [

	languageOptionsPresenter := self newDropList 
		help: 'Select the document language';
		items: self languageOptions;
		selectItem: self defaultLanguageSelection;
		whenSelectedItemChangedDo: [ : selection |
			self micHtmlDocument languageId: (selection first: 2).
			self styler updateHtmlSourcePresenter ].

]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializeLinksOptionCheckPresenter [
		
	linksOpenNewPage := self newCheckBox 
		state: true;
		whenChangedDo: [ : state |
			state 
				ifFalse: [ self micHtmlDocumentConfiguration beTargetAttributeSelf ]
				ifTrue: [ self micHtmlDocumentConfiguration beTargetAttributeBlank ].
			self styler updateHtmlSourcePresenter ]
		yourself
]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> initializePresenters [ 

	self
		initializeDocTypeListPresenter;
		initializeEncodingOptionsListPresenter;
		initializeLanguageOptionsListPresenter;
		initializeEmbeedingCheckPresenter;
		initializeLinksOptionCheckPresenter.
]

{ #category : #initialization }
MicHTMLStylerHTMLOptionsPresenter >> languageOptions [

	^ (ISOLanguageDefinition iso2LanguageTable associations 
		select: [ : assoc | assoc key size = 2 ] 
		thenCollect: [ : assoc | assoc key , ' - ' , assoc value language ]) asSortedCollection
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsPresenter >> micHtmlDocumentConfiguration [
	"Answer a <MicHTMLConfiguration> for the receiver's document"

	^ self micHtmlDocument configuration.
]
