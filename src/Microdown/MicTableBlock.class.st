"
Support for tables with a simpler and more relaxed setup than GitHub.
A table is not forced to have a header definition.

```text
| aaab | jkhjh |
| --- |
| bar |
```

or 
```text
|aaab|jkhjh|
|---|
|bar|
```
or
```text
| aaa | bbb |
|ccc |ddd |
```
or 
```text
| aaa | bbb
| cc | ddd
```
Block-level elements cannot be inserted in a table.

When a table contains a header, it is the first row, and all rows should have that size, otherwise they are truncated.

### Known limitations
How to put a pipe in a table? No support for `\|`.
"
Class {
	#name : 'MicTableBlock',
	#superclass : 'MicContinuousMarkedBlock',
	#instVars : [
		'rows',
		'hasHeader'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicTableBlock >> accept: aVisitor [
	^ aVisitor visitTable: self
]

{ #category : 'actions' }
MicTableBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form 'chararacters some text' e.g., '> some text'
	the prefix spaces after $> are removed"

	(self isHeader: line)
		ifTrue: [ hasHeader := true ]
		ifFalse: [ rows add: (self extractLine: line) ].
	
]

{ #category : 'parse support' }
MicTableBlock >> closeMe [ 

	| firstSize |
	firstSize := rows first size.
	rows := rows collect: [ :each | self cut: each toSize: firstSize ].
	rows := rows collect: [ :each | 
		        each collect: [ :e | self inlineParse: e ] ].
]

{ #category : 'private' }
MicTableBlock >> cut: row toSize: firstSize [

	^ row copyFrom: 1 to: ( row size min: firstSize)
]

{ #category : 'actions' }
MicTableBlock >> extractLine: line [
	"recondition line starts with |
	
	For now we have 
		| something | something | 
		or 
		| something | something"
	| unicodeReplacementCharacter |
		
	"allow pipe symbols to be written as \|"
	unicodeReplacementCharacter := 16rFFFD asCharacter asString. "By definition this do not appear in any input"
	 
	^ ((line copyReplaceAll: '\|' with: unicodeReplacementCharacter) findBetweenSubstrings: '|') 
			collect: [ :each | (each copyReplaceAll: unicodeReplacementCharacter with: '|') trim]
		
				
		
]

{ #category : 'accessing' }
MicTableBlock >> hasHeader [
	^ hasHeader
]

{ #category : 'initialization' }
MicTableBlock >> initialize [ 
	super initialize.
	rows := OrderedCollection new.
	hasHeader := false
]

{ #category : 'testing' }
MicTableBlock >> isHeader: line [
	"Return true whether a line is a table header identification i.e., | --- | --- |"
	
	| authorised |
	authorised := {$| . $- . Character space}.
	^  line allButFirst allSatisfy: [ :each | authorised includes: each ].
	
]

{ #category : 'markups' }
MicTableBlock >> lineMarkup [

	^ TableCellMarkup
]

{ #category : 'accessing' }
MicTableBlock >> rows [
	^ rows
]
