Class {
	#name : #MDTODO,
	#superclass : #Object,
	#category : #'Microdown-Visitor'
}

{ #category : #'as yet unclassified' }
MDTODO >> todo1 [

	'
	- rename text of MicListItemBlock text into textElements or remove it to use children
	- substring sucks call it rawString? 
	- string vs. rawString (what about nested in case of format nesting ie. **_foo_**)
	string could return foo
	raWString **_foo_**
	
	**_foo_** children first raWString 
	>>> _foo_
	
	
	- add an API in MicAbstractIinlineBlock or subclasses
	to access wrapped element. 
		**_foo_** children first  
	>>> BoldText(_foo_)
	'
]

{ #category : #'as yet unclassified' }
MDTODO >> todo2 [

	'
	MicInlineSplitter start: -> parse:
	'
]
