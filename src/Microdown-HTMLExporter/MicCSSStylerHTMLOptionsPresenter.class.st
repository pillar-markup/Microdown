"
Provides a presenter to configure common export HTML options, for example:

- The document type a.k.a DOCTYPE
- Include CSS in header.
- Set links to open to a new web page.


"
Class {
	#name : #MicCSSStylerHTMLOptionsPresenter,
	#superclass : #MicCSSStylerAbstractPresenter,
	#instVars : [
		'doctypeListPresenter',
		'embeedCheckboxPresenter',
		'linksOpenNewPage',
		'encodingOptionsListPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> charSet [

	^ encodingOptionsListPresenter selectedItem.
]

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;		
			add: 'Document Type';
			add: doctypeListPresenter;
			nextRow;
			add: 'Encoding';
			add: encodingOptionsListPresenter;
			nextRow;
			add: 'Embeed CSS';
			add: embeedCheckboxPresenter;
			nextRow;
			add: 'Links open a new page';
			add: linksOpenNewPage ]
]

{ #category : #private }
MicCSSStylerHTMLOptionsPresenter >> docTypeOptions [

	^ #(
		'XHTML 1.1'
		'XHTML 1.0 Transitional'
		'XHTML 1.0 Frameset'
		'XHTML 1.0 Strict'
		'HTML 5'
		'HTML 4.01 Transitional'
		'HTML 4.01 Frameset'
		'HTML 4.01 Strict'
		'HTML 3.2'
		'Compact HTML 2.0'
		)
]

{ #category : #accessing }
MicCSSStylerHTMLOptionsPresenter >> embeedCheckboxPresenter [

	^ embeedCheckboxPresenter
]

{ #category : #accessing }
MicCSSStylerHTMLOptionsPresenter >> enableEmbeedCss [

	self embeedCheckboxPresenter enabled: true.
]

{ #category : #private }
MicCSSStylerHTMLOptionsPresenter >> encodingOptions [

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

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> initializePresenters [ 

	doctypeListPresenter := self newDropList
		help: 'Select the document type to be generated';
		items: self docTypeOptions;
		whenSelectedItemChangedDo: [ : selection |
			self micHtmlDocument documentType: selection.
			self updateStylerPresenter ]
		yourself.
	encodingOptionsListPresenter := self newDropList 
		help: 'Select the document encoding';
		items: self encodingOptions;
		whenSelectedItemChangedDo: [ : selection | 
			self micHtmlDocument charSet: selection.
			self updateStylerPresenter ];
		yourself.
	embeedCheckboxPresenter := self newCheckBox
		state: false;
		enabled: false;
		whenChangedDo: [ 
			self micHtmlDocument embeedCss.
			self updateStylerPresenter ]
		yourself.
	linksOpenNewPage := self newCheckBox 
		state: true;
		whenChangedDo: [ 
			self micHtmlDocument linksOpenNewPage.
			self updateStylerPresenter ]
		yourself
]

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> updateStylerPresenter [

	self styler updatePresenter
]
