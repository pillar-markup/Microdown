"
I'm a kind of facade to steer Microdown services.
"
Class {
	#name : #Microdown,
	#superclass : #Object,
	#instVars : [
		'parser',
		'resolverRoot'
	],
	#category : #'Microdown-Core'
}

{ #category : #parsing }
Microdown >> initialize [ 
	super initialize.
	parser := MicroDownParser new.
	 
]

{ #category : #parsing }
Microdown >> parse: aStreamOrString [

	^ parser parse: aStreamOrString
]

{ #category : #parsing }
Microdown >> resolvedTreeFrom: aStreamOrString [

	| micTree |
	micTree := parser parse: aStreamOrString.
	self resolver 
		root: self resolverRoot ;
		visit: micTree.
	^ micTree
	
]

{ #category : #parsing }
Microdown >> resolver [
	^ MicPathResolver new root: self resolverRoot; yourself
]

{ #category : #parsing }
Microdown >> resolverRoot [
	
	^ resolverRoot ifNil: [ resolverRoot := FileSystem workingDirectory ]
]

{ #category : #parsing }
Microdown >> resolverRoot: root [
	
	resolverRoot := root
]
