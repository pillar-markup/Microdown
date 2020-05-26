"
Support table with a simple and more relax setup than github.
A table is not forced to have a header definition.

| aaab | jkhjh |
| --- |
| bar |

or 
|aaab|jkhjh|
|---|
|bar|

or 
| aaa | bbb |
|ccc |ddd |

or 
| aaa | bbb
| cc | ddd

Block-level elements cannot be inserted in a table.

When a table contains a header it is the first row and all rows should have that size else they are cut. 


Known limits: how to put a pipe in a table? 
No support for \|

"
Class {
	#name : #GHMTableBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#instVars : [
		'rows',
		'hasHeader'
	],
	#category : #'Microdown-Model'
}

{ #category : #actions }
GHMTableBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form 'chararacters some text' e.g., '> some text'
	the prefix spaces after $> are removed"

	(self isHeader: line)
		ifTrue: [ hasHeader := true ]
		ifFalse: [ rows add: (self extractLine: line) ].
	
]

{ #category : #private }
GHMTableBlock >> closeMe [ 

	| firstSize |
	firstSize := rows first size.
	rows := rows collect: [ :each | self cut: each toSize: firstSize ].
	
]

{ #category : #private }
GHMTableBlock >> cut: row toSize: firstSize [

	^ row copyFrom: 1 to: firstSize 
	
]

{ #category : #actions }
GHMTableBlock >> extractLine: line [
	"recondition line starts with |
	
	For now we have 
		| something | something | 
		or 
		| something | something"
		
		^ (line findBetweenSubstrings: #($|)) collect: [ :each | each trim ]
		
				
		
]

{ #category : #actions }
GHMTableBlock >> extractLineOld: line [
	"For now we have 
		| something | something | 
		or 
		| something | something"
		| acc rowElements cLine |
		acc := ''.
		rowElements := OrderedCollection new. 
		cLine := line allButFirst.
		cLine do: [ :each | 
				each = $|  
					ifTrue: [ rowElements add: acc trim. acc := ''  ]
					ifFalse: [ acc := acc, (String with: each) ]
						 ].
		(line last = $|)
			ifFalse: [ rowElements add: acc trim ].
		^ rowElements 			
					
		
				
		
]

{ #category : #accessing }
GHMTableBlock >> hasHeader [
	^ hasHeader
]

{ #category : #initialization }
GHMTableBlock >> initialize [ 
	super initialize.
	rows := OrderedCollection new.
]

{ #category : #testing }
GHMTableBlock >> isHeader: line [
	"Return true whether a line is a table header identification i.e., | --- | --- |"
	
	| authorised |
	authorised := {$| . $- . Character space}.
	^  line allButFirst allSatisfy: [ :each | authorised includes: each ].
	
]

{ #category : #markups }
GHMTableBlock >> lineMarkup [

	^ parser tableCellMarkup
]

{ #category : #accessing }
GHMTableBlock >> rows [
	^ rows
]
