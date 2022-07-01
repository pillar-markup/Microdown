Class {
	#name : #MicCSSAbstractPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'cssFramework'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #initialization }
MicCSSAbstractPresenter >> setModelBeforeInitialization: aDomainObject [

	cssFramework := aDomainObject
]
