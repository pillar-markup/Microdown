"
Groups common behavior and provides helpers to access MicHTMLDoc object to subclasses.
The **styler** is an instance of `MicHTMLStyler` passed as model before initialization.

"
Class {
	#name : #MicHTMLStylerAbstractPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'styler'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #updating }
MicHTMLStylerAbstractPresenter >> micHtmlDocument [ 

	^ self styler micHtmlDocument 
]

{ #category : #initialization }
MicHTMLStylerAbstractPresenter >> setModelBeforeInitialization: aDomainObject [

	styler := aDomainObject
]

{ #category : #accessing }
MicHTMLStylerAbstractPresenter >> statusBarHeight [

	^ 25
]

{ #category : #accessing }
MicHTMLStylerAbstractPresenter >> styler [

	^ styler
]

{ #category : #accessing }
MicHTMLStylerAbstractPresenter >> stylerDetailsPresenter [

	^ self styler cssDetailsPresenter
]
