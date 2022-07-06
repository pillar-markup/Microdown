Class {
	#name : #MicCSSStylerAbstractPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'styler'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #updating }
MicCSSStylerAbstractPresenter >> micHtmlDocument [ 

	^ self styler micHtmlDocument 
]

{ #category : #initialization }
MicCSSStylerAbstractPresenter >> setModelBeforeInitialization: aDomainObject [

	styler := aDomainObject
]

{ #category : #accessing }
MicCSSStylerAbstractPresenter >> styler [

	^ styler
]
