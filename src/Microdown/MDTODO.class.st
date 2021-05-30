Class {
	#name : #MDTODO,
	#superclass : #Object,
	#category : #'Microdown-Visitor'
}

{ #category : #'as yet unclassified' }
MDTODO >> todo01 [

	^ 'remove all the method around structure and contents
	This should be job of the textual displayer'
]

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
MDTODO >> todo3 [

	'
	- label in figure is used as an anchor for future ref following latex vocabulary.
	- annotated paragraph used label as title. 
	=> solution
		label in annotation should be called title first.
		then if we want we can decide to rename the label in figure/math....
	
	
	
	'
]

{ #category : #'as yet unclassified' }
MDTODO >> todo4 [

	'
	Create a test for annotatedBlock asPillar. 
	Copy a bit from list tests.
	
	
	
	'
]
