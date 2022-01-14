"
A SpRichTextPresenterTest is a test class for testing the behavior of SpRichTextPresenter
"
Class {
	#name : #MicTextPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Microdown-RichTextPresenter-Tests'
}

{ #category : #accessing }
MicTextPresenterTest >> adapter [
	"We do not use this for anything. 
	When the framework start using this, give us an error so we can fix it"
	self error: 'Somewhere the frameworks started using this method - can we use it?'
]

{ #category : #accessing }
MicTextPresenterTest >> classToTest [
	^ MicTextPresenter 
]

{ #category : #running }
MicTextPresenterTest >> setUp [
	super setUp.
]

{ #category : #tests }
MicTextPresenterTest >> testAdapterExists [
	self openInstance.
	self assert: presenter adapter notNil
]

{ #category : #tests }
MicTextPresenterTest >> testHugeFontIsHuge [
	| hugeText pointSize |
	pointSize := 104.
	hugeText := 'huge' asText addAttribute: 
		(TextFontReference toFont: (LogicalFont
			familyName: 'Source Sans Pro'
			pointSize: pointSize)).
	presenter text: hugeText.
	self openInstance.
	self assert: presenter adapter widget textArea height > pointSize 
]

{ #category : #tests }
MicTextPresenterTest >> testSelectAll [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectAll.
	self assert: presenter selectedText equals: txt
]

{ #category : #tests }
MicTextPresenterTest >> testSelectNone [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectNone.
	self assert: presenter selectedText equals: '' asText
]

{ #category : #tests }
MicTextPresenterTest >> testSelectSome [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter selectionInterval: (6 to: 9).
	self assert: presenter selectedText equals: 'text' asText
]

{ #category : #tests }
MicTextPresenterTest >> testSelectSomeOther [
	| txt |
	txt := 'some text to select' asText.
	self openInstance.
	presenter text: txt. "Setting text after open"
	presenter selectionInterval: (6 to: 9).
	self assert: presenter selectedText equals: 'text' asText
]

{ #category : #tests }
MicTextPresenterTest >> testSelectingInEditor [
	| txt |
	txt := 'some text to select' asText.
	presenter text: txt.
	self openInstance.
	presenter adapter widget selectionInterval: (14 to: 19).
	self assert: presenter selectedText equals: 'select' asText
]

{ #category : #tests }
MicTextPresenterTest >> testWidgetExists [
	self openInstance.
	self assert: presenter adapter widget notNil
]

{ #category : #tests }
MicTextPresenterTest >> testwhenSelectionChangedDo [
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
MicTextPresenterTest >> testwhenSelectionChangedDoFromEditor [
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
MicTextPresenterTest >> testwhenTextChangedDo [
	| wasHere |
	wasHere := false.
	presenter whenTextChangedDo: [ wasHere := true ].
	presenter text: 'some text' asText.
	self assert: wasHere
]
