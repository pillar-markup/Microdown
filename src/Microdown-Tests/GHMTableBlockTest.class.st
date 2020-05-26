Class {
	#name : #GHMTableBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMTableBlockTest >> testExtractLine [

	| table sep |
	table := GHMTableBlock new.
	sep := parser tableCellMarkup.
	self assert: (table extractLine:  sep, ' x y ', sep,  ' z k ', sep) asArray equals: #( 'x y' 'z k').
	self assert: (table extractLine:  sep, 'x y', sep,  'z k', sep) asArray equals: #( 'x y' 'z k').

]

{ #category : #tests }
GHMTableBlockTest >> testExtractLineSupportEmptyCell [

	| table sep |
	table := GHMTableBlock new.
	sep := parser tableCellMarkup.
	self assert: (table extractLine:  sep, ' x y ', sep,  ' z k ', sep, ' ', sep) asArray equals: #( 'x y' 'z k' '').
	self assert: (table extractLine:  sep, '    ', sep,  ' z k ', sep, ' oui ', sep) asArray equals: #( '' 'z k' 'oui').
	
]

{ #category : #tests }
GHMTableBlockTest >> testExtractLineSupportUnfinished [

	| table sep |
	table := GHMTableBlock new.
	sep := parser tableCellMarkup.
	self assert: (table extractLine: sep, ' x y ', sep , ' z k') asArray equals: #( 'x y' 'z k').

]

{ #category : #tests }
GHMTableBlockTest >> testIsHeaderLine [

	| table sep |
	table := GHMTableBlock new.
	sep := parser tableCellMarkup.
	self assert: (table isHeader: sep, ' -- ', sep, ' -- ', sep).
]

{ #category : #tests }
GHMTableBlockTest >> testIsNotHeaderLine [

	| table sep |
	table := GHMTableBlock new.
	sep := parser tableCellMarkup.
	self deny: (table isHeader: sep, ' a - a - ', sep , ' --- ', sep).
	self deny: (table isHeader: sep, ' ----- ', sep, ' k').
]

{ #category : #tests }
GHMTableBlockTest >> testSimpleTable [

	| source root table |
	source := '| col1 row1 | col2 row1 |
| col1 row2 | col2 row2 |'.
	root := parser parse: source.
	table := root children first.
	self assert: (table isKindOf: GHMTableBlock).
	self assert: table rows first asArray equals: #('col1 row1'  'col2 row1').
	self assert: table rows second asArray equals: #('col1 row2'  'col2 row2').
]

{ #category : #tests }
GHMTableBlockTest >> testSimpleTableChopped [

	| source root table |
	source := '| col1 row1 | col2 row1 |
| col1 row2 | col2 row2 |  col3 row2 |  col4 row2 '.
	root := parser parse: source.
	table := root children first.
	self assert: table rows first asArray equals: #('col1 row1'  'col2 row1').
	self assert: table rows second asArray equals: #('col1 row2'  'col2 row2').
	self assert: table rows first size equals: 2
]

{ #category : #tests }
GHMTableBlockTest >> testTableWithHeader [

	| source root table |
	source := '| col1 row1 | col2 row1 |
| -- | - |	
| col1 row2 | col2 row2 | col4 row2 |
| col1 row3 |   | col3 row3 |  c '.

	root := parser parse: source.
	table := root children first.
	self assert: table rows second asArray equals: #('col1 row2'  'col2 row2').
	self assert: table rows third asArray equals: #('col1 row3'  '').
]
