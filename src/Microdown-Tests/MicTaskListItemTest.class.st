"
I test the parsing of GitHub-style task list items in Microdown lists.

## Responsibility:

- Check that `- [ ] text`, `- [x] text` and `- [X] text` produce a `MicListItemBlock` that is a task, unchecked or checked.
- Check that items which only look like tasks (`- [ ]a`, `- [y] a`, `- [link](url)`, `- \[ ] a`) stay normal items.
- Check that the task marker is removed from the item text and that nesting, multi-line items and ordered lists work.

## Collaborators: 

- `MicrodownParser` parses the source given in each test.
- `MicListItemBlock` is the element whose `isTask` and `isChecked` are asserted.

## Public API and Key Messages

- `itemsOf:` answers the items of the first list of a source.

```
MicTaskListItemTest run: #testUncheckedTask
```

"
Class {
	#name : 'MicTaskListItemTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'helpers' }
MicTaskListItemTest >> itemsOf: aString [
	"Answer the items of the first list found in aString."

	^ (parser parse: aString) children first children
]

{ #category : 'tests' }
MicTaskListItemTest >> subjectClass [

	^ MicListItemBlock
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testCheckedMarkerWithoutSpaceAfterBulletIsAParagraph [
	"As in GFM, a bullet must be followed by a space to start a list."

	| block |
	block := (parser parse: '-[x] done') children first.
	self assert: block class equals: MicParagraphBlock.
	self assert: block children first bodyString equals: '-[x] done'
]

{ #category : 'tests' }
MicTaskListItemTest >> testCheckedTaskLowercase [

	| item |
	item := (self itemsOf: '- [x] done') first.
	self assert: item isTask.
	self assert: item isChecked.
	self assert: item testText equals: 'Text(done)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testCheckedTaskUppercase [

	| item |
	item := (self itemsOf: '- [X] done') first.
	self assert: item isTask.
	self assert: item isChecked.
	self assert: item testText equals: 'Text(done)'
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testEmptyBracketsAreNotATask [
	"As in GFM, the box needs a space or an x inside: '[]' stays text."

	| item |
	item := (self itemsOf: '- [] todo') first.
	self deny: item isTask.
	self assert: item testText equals: 'Text([] todo)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testEmptyTask [

	| item |
	item := (self itemsOf: '- [ ]') first.
	self assert: item isTask.
	self deny: item isChecked.
	self assert: item children isEmpty
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testEscapedBracketIsNotATask [

	| item |
	item := (self itemsOf: '- \[ ] a') first.
	self deny: item isTask
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testLinkIsNotATask [

	| item |
	item := (self itemsOf: '- [x](http://pharo.org)') first.
	self deny: item isTask.
	self assert: item children first class equals: MicLinkBlock
]

{ #category : 'tests' }
MicTaskListItemTest >> testMixedTaskAndNormalItems [

	| items |
	items := self itemsOf: '- [ ] task
- normal
- [x] done'.
	self assert: (items collect: [ :each | each isTask ] as: Array) equals: #( true false true ).
	self assert: items second testText equals: 'Text(normal)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testMultiLineTask [

	| item |
	item := (self itemsOf: '- [x] first line
  second line') first.
	self assert: item isChecked.
	self assert: item testText equals: 'Text(first line
second line)' withInternalLineEndings
]

{ #category : 'tests' }
MicTaskListItemTest >> testNestedTasks [

	| items nested |
	items := self itemsOf: '- [ ] parent
  - [x] child
  - [ ] other child'.
	self assert: items size equals: 1.
	self assert: items first isTask.
	self deny: items first isChecked.
	nested := items first children last children.
	self assert: (nested collect: [ :each | each isChecked ] as: Array) equals: #( true false ).
	self assert: nested first testText equals: 'Text(child)'
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testNoSpaceAfterMarkerIsNotATask [

	| item |
	item := (self itemsOf: '- [ ]a') first.
	self deny: item isTask.
	self assert: item testText equals: 'Text([ ]a)'
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testNormalItemIsNotATask [

	| item |
	item := (self itemsOf: '- buy milk') first.
	self deny: item isTask.
	self deny: item isChecked
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testOtherLetterIsNotATask [

	| item |
	item := (self itemsOf: '- [y] a') first.
	self deny: item isTask.
	self assert: item testText equals: 'Text([y] a)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testTaskInOrderedList [

	| items |
	items := self itemsOf: '1. [ ] first
2. [x] second'.
	self assert: (parser parse: '1. [ ] first') children first class equals: MicOrderedListBlock.
	self assert: items first isTask.
	self deny: items first isChecked.
	self assert: items second isChecked.
	self assert: items second testText equals: 'Text(second)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testTaskWithFormatting [

	| item |
	item := (self itemsOf: '- [x] **bold** task') first.
	self assert: item isChecked.
	self assert: item testText equals: 'BoldFormat{ Text(bold) }Text( task)'
]

{ #category : 'tests' }
MicTaskListItemTest >> testTaskWithOtherBullets [

	| items |
	items := self itemsOf: '* [ ] star
* [x] star done'.
	self assert: (items collect: [ :each | each isChecked ] as: Array) equals: #( false true ).
	items := self itemsOf: '+ [x] plus'.
	self assert: items first isChecked
]

{ #category : 'tests - not a task' }
MicTaskListItemTest >> testUncheckedMarkerWithoutSpaceAfterBulletIsAParagraph [
	"As in GFM, a bullet must be followed by a space to start a list."

	| block |
	block := (parser parse: '-[ ] todo') children first.
	self assert: block class equals: MicParagraphBlock.
	self assert: block children first bodyString equals: '-[ ] todo'
]

{ #category : 'tests' }
MicTaskListItemTest >> testUncheckedTask [

	| item |
	item := (self itemsOf: '- [ ] buy milk') first.
	self assert: item isTask.
	self deny: item isChecked.
	self assert: item testText equals: 'Text(buy milk)'
]
