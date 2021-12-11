"
Microdown is a minimal but extensible markup language. It is kind of compatible with githubmarkdown for a core set of feature. 
Read comment of MicroDownParser. 
"
Class {
	#name : #BaselineOfMicrodown,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodown
}

{ #category : #baselines }
BaselineOfMicrodown >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'PillarCore'
			with: [
				spec  
					loads: #('Pillar-Core');
					repository: 'github://pillar-markup/pillar:dev-8'
			].
		spec
			package: #Microdown;
			package: #'Microdown-Tests'
				with: [ spec requires: #( #Microdown ) ];
		
			package: #'Microdown-Pharo-Tools'
				with: [ spec requires: #( #Microdown ) ];
				
			package: #'Microdown-RichTextComposer'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-RichTextComposer-Tests'
				with: [ spec requires: #( #'Microdown-RichTextComposer' ) ];

			package: #'Microdown-Transformer'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-Transformer-Tests'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];

			package: #'Microdown-Evaluator'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];
			package: #'Microdown-Evaluator-Tests'
				with: [ spec requires: #( #'Microdown-Evaluator' ) ];
			
			package: #'Microdown-HTMLExporter'
				with: [ spec requires: #( #Microdown #'Microdown-LaTeXExporter') ];
			
			package: #'Microdown-LaTeXExporter'
				with: [ spec requires: #( #Microdown ) ];

			package: #'Microdown-LaTeXExporter-Tests'
				with: [ spec requires: #( #'Microdown-LaTeXExporter' #'Microdown-Tests') ];

			package: #'Microdown-PrettyPrinter'
				with: [ spec requires: #( #Microdown ) ];
			
			"contains the asPillar and converter from MD to Pillar"
			package: #'Microdown-Pillar'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-Pillar-Tests'
				with: [ spec requires: #( #'Microdown-Pillar' ) ];	

			package: #'Microdown-PrettyPrinter-Tests'
				with: [ spec requires: #( #'Microdown-PrettyPrinter' #'Microdown-Tests') ].
	
		"I do not want group without tests for now"
		spec
			group: 'Core' 
			with: #(
				#'Microdown'
				#'Microdown-Tests'
				);
			group: 'RichText' with: #('Core' #'Microdown-RichTextComposer' );
			group: 'Extensions' 
			with: #(   
				#'Microdown-Evaluator'
				#'Microdown-Evaluator-Tests'
				#'Microdown-PrettyPrinter'
				#'Microdown-PrettyPrinter-Tests'
				#'Microdown-HTMLExporter'
				#'Microdown-LaTeXExporter'
				#'Microdown-LaTeXExporter-Tests'
				#'Microdown-Transformer'
				#'Microdown-Transformer-Tests');
			group: 'All' 
			with: #('Core' 'Extensions' #'Microdown-Pharo-Tools' 'RichText')  ]
]
