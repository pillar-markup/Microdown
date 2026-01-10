Class {
	#name : 'MicParagraphMissingLabelPeriodRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Others',
	#package : 'Microdown-Rules',
	#tag : 'Others'
}

{ #category : 'as yet unclassified' }
MicParagraphMissingLabelPeriodRule >> detectIncorrectLabel: trimmed [

	| labelRegex |
	labelRegex := '^\d+[A-Za-z]*\s.*' asRegex.
	^ (labelRegex matches: trimmed) and: [
		  (trimmed beginsWith: trimmed substrings first , '.') not ]
]

{ #category : 'as yet unclassified' }
MicParagraphMissingLabelPeriodRule >> detectIncorrectLabel: trimmed for: firstWord [

	| labelRegex |
	labelRegex := '^\d+[A-Za-z]*\s.*' asRegex.
	^ (labelRegex matches: trimmed) and: [
		  (trimmed beginsWith: trimmed substrings first , '.') not ]
]
