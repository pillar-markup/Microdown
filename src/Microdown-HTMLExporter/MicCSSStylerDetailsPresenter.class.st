Class {
	#name : #MicCSSStylerDetailsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'cssMetaInfoPresenter',
		'cssSourceCodePresenter',
		'cssFramework'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework [

	^ cssFramework
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework: anObject [

	cssFramework := anObject.
	self updatePresenter
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssMetaInfoPresenter [

	^ cssMetaInfoPresenter
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssSourceCodePresenter [

	^ cssSourceCodePresenter
]

{ #category : #layout }
MicCSSStylerDetailsPresenter >> defaultLayout [ 

	^ self layout: (SpPanedLayout newTopToBottom 
		positionOfSlider: 45 percent;
		add: cssMetaInfoPresenter;
		add: cssSourceCodePresenter;
		yourself)
]

{ #category : #layout }
MicCSSStylerDetailsPresenter >> initializePresenters [ 

	cssMetaInfoPresenter := self instantiate: MicCSSStylerMetaInfoPresenter on: self cssFramework.
	cssSourceCodePresenter := self newText.
]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> setModelBeforeInitialization: aDomainObject [

	cssFramework := aDomainObject.
]

{ #category : #layout }
MicCSSStylerDetailsPresenter >> updatePresenter [

	self cssMetaInfoPresenter updatePresenter.
	self cssSourceCodePresenter text: 'Not downloaded'"self cssFramework cssFile contents."
]
