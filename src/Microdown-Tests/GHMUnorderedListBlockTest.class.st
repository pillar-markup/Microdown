"
A GHMOrderedListBlockTest is a test class for testing the behavior of GHMOrderedListBlock
"
Class {
	#name : #GHMUnorderedListBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMUnorderedListBlockTest >> testEmbeddedOrdered [
	| source root list |
	source := 
'- item 1
  1. sublevel item 1
  4. sublevel item 2
- item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'.
	self assert: list children first "item 1"
			children first "unordered list"
			children second "sub item"
			text equals: 'sublevel item 2'
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testSingleLevelList [
	| source root list |
	source := 
'- item 1
- item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testSingleLevelList2 [
	| source root list |
	source := 
'- item 1
  expanded
- item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children first text equals: 'item 1
expanded'
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testSingleLevelListWithStar [
	| source root list |
	source := 
'* item 1
* item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testSingleLevelMixedList [
	| source root list |
	source := 
'- item 1
* item 2
- item 3'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 3.
	self assert: list children second text equals: 'item 2'
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testTwoLevelList [
	| source root list |
	source := 
'- item 1
  * sublevel1
  * sublevel2
- item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'.
	self assert: list children first "item 1"
			children first "unorded list"
			children first "sub item"
			text equals: 'sublevel1'.
	self assert: list children first "item 1"
			children first "unorded list"
			children second "sub item"
			text equals: 'sublevel2'
			
]

{ #category : #tests }
GHMUnorderedListBlockTest >> testTwoLevelList1 [
	| source root list |
	source := 
'- item 1
  - sublevel
- item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'.
	self assert: list children first "item 1"
			children first "unorded list"
			children first "sub item"
			text equals: 'sublevel'
]
