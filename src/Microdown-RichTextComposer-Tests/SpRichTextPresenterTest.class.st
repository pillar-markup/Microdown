"
A SpRichTextPresenterTest is a test class for testing the behavior of SpRichTextPresenter
"
Class {
	#name : #SpRichTextPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Microdown-RichTextComposer-Tests-Presenter'
}

{ #category : #accessing }
SpRichTextPresenterTest >> adapter [
	"We do not use this for anything. 
	When the framework start using this, give us an error so we can fix it"
	self error: 'Somewhere the frameworks started using this method - can we use it?'
]

{ #category : #accessing }
SpRichTextPresenterTest >> classToTest [
	^ SpRichTextPresenter 
]

{ #category : #running }
SpRichTextPresenterTest >> setUp [
	super setUp.
]

{ #category : #tests }
SpRichTextPresenterTest >> testAdapterExists [
	self openInstance.
	self assert: presenter adapter notNil
]

{ #category : #tests }
SpRichTextPresenterTest >> testSelectAll [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectAll.
	self assert: presenter selectedText equals: txt
]

{ #category : #tests }
SpRichTextPresenterTest >> testSelectNone [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectNone.
	self assert: presenter selectedText equals: '' asText
]

{ #category : #tests }
SpRichTextPresenterTest >> testSelectSome [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectionInterval: (6 to: 9).
	self assert: presenter selectedText equals: 'text' asText
]

{ #category : #tests }
SpRichTextPresenterTest >> testSelectSomeOther [
	| txt |
	txt := 'some text to select' asText.
	self openInstance.
	presenter text: txt. "Setting text after open"
	presenter selectionInterval: (6 to: 9).
	self assert: presenter selectedText equals: 'text' asText
]

{ #category : #tests }
SpRichTextPresenterTest >> testSelectingInEditor [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter adapter widget selectionInterval: (14 to: 19).
	self assert: presenter selectedText equals: 'select' asText
]

{ #category : #tests }
SpRichTextPresenterTest >> testWidgetExists [
	self openInstance.
	self assert: presenter adapter widget notNil
]

{ #category : #tests }
SpRichTextPresenterTest >> testwhenSelectionChangedDo [
	| txt wasHere |
	wasHere := false.
	txt := 'some text to select' asText.
	presenter text: txt.
	presenter whenSelectionChangedDo: [ wasHere := true ].
	self openInstance.
	presenter selectionInterval: (14 to: 19).
	self assert: wasHere
]

{ #category : #tests }
SpRichTextPresenterTest >> testwhenSelectionChangedDoFromEditor [
	| txt wasHere |
	wasHere := false.
	txt := 'some text to select' asText.
	presenter text: txt.
	presenter whenSelectionChangedDo: [ wasHere := true ].
	self openInstance.
	presenter adapter widget selectionInterval: (14 to: 19).
	self assert: wasHere
]

{ #category : #tests }
SpRichTextPresenterTest >> testwhenTextChangedDo [
	| wasHere |
	wasHere := false.
	presenter whenTextChangedDo: [ wasHere := true ].
	presenter text: 'some text' asText.
	self assert: wasHere
]
