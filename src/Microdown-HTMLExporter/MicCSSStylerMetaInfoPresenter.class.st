Class {
	#name : #MicCSSStylerMetaInfoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectUrlPresenter',
		'cssLinkPresenter',
		'themesListPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicCSSStylerMetaInfoPresenter >> cssFramework [

	^ self owner cssFramework
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> cssLinkPresenter [

	^ cssLinkPresenter
]

{ #category : #layout }
MicCSSStylerMetaInfoPresenter >> defaultLayout [

	^ self layout: (SpGridLayout build: [ : builder |
		builder 
			add: 'Repository';
			add: projectUrlPresenter;
			nextRow;
			add: 'CSS';
			add: cssLinkPresenter;
			nextRow;
			add: 'Themes';
			add: themesListPresenter ])
]

{ #category : #layout }
MicCSSStylerMetaInfoPresenter >> initializePresenters [ 

	projectUrlPresenter := self newLink.
	cssLinkPresenter := self newLink.
	themesListPresenter := self newList.

]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> projectUrlPresenter [

	^ projectUrlPresenter
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> updatePresenter [

	projectUrlPresenter
		url: self cssFramework mainUrl;
		label: self cssFramework mainUrl;
		action: [ self openLink: projectUrlPresenter url ].		
	cssLinkPresenter
		url: self cssFramework cssUrl;	
		label: self cssFramework cssUrl;
		action: [ self openLink: cssLinkPresenter url ].	
	themesListPresenter items: #().


]
