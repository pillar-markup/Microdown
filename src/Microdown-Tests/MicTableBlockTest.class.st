Class {
	#name : 'MicTableBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicTableBlockTest >> subjectClass [
	^ MicTableBlock 
]

{ #category : 'tests' }
MicTableBlockTest >> testExtractLine [

	| checker |
	checker := [ :source | | result |
		result := MicTableBlock new extractLine: source.
		self assert: result size equals: 3.
		self assert: result second equals: 'bbb'.
	].
	checker value: '| aaa | bbb | ccc'.
	checker value: '| aaa | bbb | ccc  '.
	checker value: '| aaa | bbb | ccc |'.
	checker value: '| aaa | bbb | ccc |   '.
]

{ #category : 'tests' }
MicTableBlockTest >> testTableNoHeader [
	"A header can only contain --- space and |"
	
	| source  |
	source := '| AAA | BBB | CCC '.
	self deny: (MicTableBlock new isHeader: source).
	source := '| AAA | BBB | CCC |'."Nothing after |"
	self deny: (MicTableBlock new isHeader: source).
]

{ #category : 'tests' }
MicTableBlockTest >> testTableWithHeader [

	| source  |
	source := '| --- | --- | ---'.
	self assert: (MicTableBlock new isHeader: source).
	source := '| --- | --- | --- |'.
	self assert: (MicTableBlock new isHeader: source).
	source := '| --- | --- | --- | '.
	self assert: (MicTableBlock new isHeader: source).
]
