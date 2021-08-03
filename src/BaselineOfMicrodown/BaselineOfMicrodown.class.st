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
			package: #Microdown;
			package: #'Microdown-Tests'
				with: [ spec requires: #( #Microdown ) ];
			
			package: #'Microdown-ResolvePath'
				with: [ spec requires: #( #'Microdown' ) ];	
			package: #'Microdown-ResolvePath-Tests'
				with: [ spec requires: #( #'Microdown-ResolvePath' ) ];
		
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
				with: [ spec requires: #( #'Microdown-PrettyPrinter' #'Microdown-Tests') ].
	
		"I do not want group without tests for now"
		spec
			group: 'Core' 
			with: #(
				#'Microdown'
				#'Microdown-Tests'
				#'Microdown-ResolvePath' 
				#'Microdown-ResolvePath-Tests' 
				);
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
