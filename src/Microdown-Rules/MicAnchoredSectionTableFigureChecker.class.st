"
I check that references to figures, sections and tables are correctly capitalized before an anchor.
In Microdown, references should be written as:
	Figure *@figureExample@*
	Section *@sectionExample@*
	Table *@tableExample*
	
The following are incorrect and will be flagged:
	figure *@figureExample@* (lowercase)
	the figure *@figureExample@* (proceded by 'the')
	section *@sectionExample@* (lowercase)
"
Class {
	#name : 'MicAnchoredSectionTableFigureChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-References',
	#package : 'Microdown-Rules',
	#tag : 'References'
}

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> visitParagraph: aMicParagraph [
	| children |
	children := aMicParagraph children.
	1 to: children size - 1 do: [  :index |
		| child nextChild |
		child := children at: index.
		nextChild := children at: index + 1.
		(nextChild isKindOf: MicAnchorReferenceBlock ) ifTrue: [ 
			(child isKindOf: MicTextBlock ) ifTrue: [ 
				| words lastWord foundThe |
				words := child bodyString substrings.
				words isEmpty ifFalse:[
					lastWord := words last.
					foundThe := false.
					"verify the figure/section/table"
					#('figure' 'section' 'table') do: [ :ref |
						(lastWord asLowercase = ref) ifTrue: [ 
							words size > 1 ifTrue: [ 
								| prevWord |
								prevWord := words at: words size - 1.
								(prevWord asLowercase = 'the') ifTrue: [ 
									foundThe := true.
									results add: (MicFigSectTableResult new 
										micElement: child;
										inFile: aMicParagraph fromFile;
										detail: 'the ' , lastWord;
										yourself 
									)
									 ] 
								 ]
							 ]
						
						 ].
					"check figure/section/table"
					foundThe ifFalse: [ 
						#('figure' 'table' 'section') do: [ :ref |
							(lastWord = ref) ifTrue: [ 
								results add: (MicFigSectTableResult new 
									micElement: child;
									inFile: aMicParagraph fromFile;
									detail: lastWord;
									yourself 
								)
								 ]
							 ]
						 
						
						 ]
								 ]
			 ]
		 ] 
	]
]
