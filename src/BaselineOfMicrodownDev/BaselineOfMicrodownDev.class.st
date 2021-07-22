Class {
	#name : #BaselineOfMicrodownDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodownDev
}

{ #category : #baselines }
BaselineOfMicrodownDev >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'PillarDocumentModel'
			with: [ spec repository: 'github://pillar-markup/pillar:dev-8/src' ].
		spec
			package: #Microdown;
			package: #'Microdown-Tests'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-ResolvePath-Tests'
				with: [ spec requires: #( #'Microdown-ResolvePath' ) ];
			package: #'Microdown-Tests'
				with: [ spec requires: #( #Microdown ) ];	
		
			package: #'Microdown-Pharo-Tools'
				with: [ spec requires: #( #Microdown ) ];
				
			package: #'Microdown-MicrodownRichTextComposer'
				with: [ spec requires: #( #Microdown ) ];

			package: #'Microdown-Transformer'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-Transformer-Tests'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];

			package: #'Microdown-Evaluator'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];
			package: #'Microdown-Evaluator-Tests'
				with: [ spec requires: #( #'Microdown-Evaluator' ) ];

			package: #'Microdown-PrettyPrinter'
				with: [ spec requires: #( #Microdown ) ];

			package: #'Microdown-PrettyPrinter-Tests'
				with: [ spec requires: #( #'Microdown-PrettyPrinter' #'Microdown-Tests') ];

			package: #'Microdown-Pillar'
				with: [ spec requires: #( #Microdown #PillarDocumentModel ) ];
			package: #'Microdown-Pillar-Tests'
				with: [ spec requires: #( #'Microdown-Pillar' #'Microdown-Tests' ) ].
	
		"I do not want group without tests for now"
		spec
			group: 'Core' 
			with: #(
				#'Microdown'
				#'Microdown-Tests'
				#'Microdown-ResolvePath' 
				#'Microdown-ResolvePath-Tests' 
				);
			group: 'Pillar' 
			with: #(
				#'Microdown' 
				#'Microdown-Tests' 
				#'Microdown-Pillar' 
				#'Microdown-Pillar-Tests' );
			group: 'RichText' with: #('Core' #'Microdown-MicrodownRichTextComposer' );
			group: 'Extensions' 
			with: #(
				#'Microdown-Evaluator'
				#'Microdown-Evaluator-Tests'
				#'Microdown-PrettyPrinter'
				#'Microdown-PrettyPrinter-Tests'
				#'Microdown-Transformer'
				#'Microdown-Transformer-Tests');
			group: 'All' 
			with: #('Core' 'Extensions' #'Microdown-Pharo-Tools' 'RichText')  ]
]
