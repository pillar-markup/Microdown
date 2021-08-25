Extension { #name : #MicTableBlock }

{ #category : #'*Microdown-LaTeXExporter' }
MicTableBlock >> latexSpecification [
	^ String new: rows first size withAll: $l
]
