Class {
	#name : #MicrodownSpecComponentForTest,
	#superclass : #SpPresenter,
	#instVars : [
		'mdPresenter',
		'doc1',
		'doc2'
	],
	#category : #'Microdown-RichTextComposer-Tests-Presenter'
}

{ #category : #specs }
MicrodownSpecComponentForTest class >> defaultSpec [ 
	^ SpBoxLayout newVertical 
		add: #mdPresenter;
		add: (SpBoxLayout newHorizontal 
			add: #doc1; 
			add: #doc2; 
			yourself);
		yourself
]

{ #category : #specs }
MicrodownSpecComponentForTest class >> open [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
MicrodownSpecComponentForTest >> doc1 [

	^ doc1
]

{ #category : #accessing }
MicrodownSpecComponentForTest >> doc2 [

	^ doc2
]

{ #category : #initialization }
MicrodownSpecComponentForTest >> initializePresenter [
	mdPresenter := self instantiate: MicrodownPresenter.
	doc1 := self newButton
		label: 'header 1';
		action: [ self setDoc1 ].
	doc2 := self newButton
		label: 'header 2';
		action: [ self setDoc2 ]
]

{ #category : #accessing }
MicrodownSpecComponentForTest >> mdPresenter [

	^ mdPresenter
]

{ #category : #initialization }
MicrodownSpecComponentForTest >> setDoc1 [
	mdPresenter document: (Microdown parse: '# Header 1')
]

{ #category : #initialization }
MicrodownSpecComponentForTest >> setDoc2 [
	mdPresenter document: (Microdown parse: '# Header 2')
]
