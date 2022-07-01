"
Provides a presenter to configure common export HTML options, for example:

- The document type a.k.a DOCTYPE
- Include CSS in header.
- Set links to open to a new web page.


"
Class {
	#name : #MicCSSStylerHTMLOptionsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'doctypeListPresenter',
		'markupIndentStyleListPresenter',
		'embeedCheckboxPresenter',
		'linksOpenNewPage'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;		
			add: 'Document Type';
			add: doctypeListPresenter;
			nextRow;
			add: 'Indent Type';
			add: markupIndentStyleListPresenter;
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

{ #category : #layout }
MicCSSStylerHTMLOptionsPresenter >> initializePresenters [ 

	doctypeListPresenter := self newDropList
		help: 'Select the document type to be generated';
		items: self docTypeOptions;
		yourself.
	markupIndentStyleListPresenter := self newDropList 
		help: 'Select the spacing character';
		items: self markupIndentStyleOptions;
		yourself.
	embeedCheckboxPresenter := self newCheckBox
		state: false;
		yourself.
	linksOpenNewPage := self newCheckBox 
		state: true;
		yourself
]

{ #category : #private }
MicCSSStylerHTMLOptionsPresenter >> markupIndentStyleOptions [

	^ #(
		'Spaces'
		'Tabs'
		)
]
