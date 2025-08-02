"
A MicRichTextTableTest is a test class for testing the behavior of MicRichTextTable
"
Class {
	#name : 'MicRichTextTableTest',
	#superclass : 'TestCase',
	#instVars : [
		'tableBlock',
		'header',
		'rowShort',
		'row3'
	],
	#category : 'Microdown-RichTextComposer-Tests-Table-Support',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Table-Support'
}

{ #category : 'running' }
MicRichTextTableTest >> setUp [ 

	super setUp.

	tableBlock := MicTableBlock new.

	header := { 'Header' asText . 'with' asText . '3 columns' asText }.
	rowShort := OrderedCollection withAll: { 'Row' asText . 'with 2 columns' asText }.
	row3 := { 'Row' asText . 'with' asText . '3 columns' asText }.

]

{ #category : 'tests' }
MicRichTextTableTest >> testRowWith2Columns [
	"if one row is shorter (less columns) than the header, add columns to it"
	| table |

	table := MicRichTextTable headers: header rows: { rowShort }.

	self assert: table columns size equals: 3.
	self assert: table container exposedRows anyOne submorphs size equals: 3
]

{ #category : 'tests' }
MicRichTextTableTest >> testRowWith3Columns [

	| table |

	table := MicRichTextTable headers: header rows: { row3 }.

	self assert: table columns size equals: 3
]

{ #category : 'tests' }
MicRichTextTableTest >> testTableHeader [

	| table |

	table := MicRichTextTable headers: header rows: { row3 }.

	self assert: table columns size equals: 3.

	table columns do: [ :aFTColumn |
		self assert: aFTColumn id isNotNil
	]
]

{ #category : 'tests' }
MicRichTextTableTest >> testTableRows [

	| table |

	table := MicRichTextTable headers: header rows: { row3 . row3 }.

	self assert: table container exposedRows size equals: 2
]
