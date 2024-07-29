"
Microdown is a minimal but extensible markup language. It is kind of compatible with githubmarkdown for a core set of feature. 
Read comment of MicroDownParser. 
"
Class {
	#name : 'BaselineOfMicrodown',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicrodown',
	#package : 'BaselineOfMicrodown'
}

{ #category : 'baselines' }
BaselineOfMicrodown >> baseline: spec [

	<baseline>
	spec for: #common do: [

		self xmlParserHtml: spec.
		self mustache: spec.
		" I disable this because against all my best effort, I cannot avoid the fucking pop up to raise 
		even if I unload all the packages. I get the Microdown-RichTextComposer in conflict."
			
		spec preLoadDoIt: #'preload:package:'.
		
		
		"I disable this because in a postload 
			(IceRepository repositoryNamed: 'microdown') is nil and I do not get why"
	
		spec postLoadDoIt: #'postload:package:'.
		
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

			package: #'Microdown-MathFlaky-Tests'
				with: [ spec requires: #( #'Microdown-RichTextComposer-Tests' ) ];

			"package: #'Microdown-RichTextPresenter'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-RichTextPresenter-Tests'
				with: [ spec requires: #( #'Microdown-RichTextPresenter' ) ];
				
			package: #'Microdown-DocumentBrowser'
				with: [ spec requires: #( #Microdown #'Microdown-RichTextPresenter') ];
			package: #'Microdown-DocumentBrowser-Tests'
				with: [ spec requires: #( #'Microdown-DocumentBrowser' ) ];"

			package: #'Microdown-Transformer'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-Transformer-Tests'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];

			package: #'Microdown-Evaluator'
				with: [ spec requires: #( #'Microdown-Transformer' ) ];
			package: #'Microdown-Evaluator-Tests'
				with: [ spec requires: #( #'Microdown-Evaluator') ];
			
			package: #'Microdown-HTMLExporter'
				with: [ spec requires: #( #Microdown #'Microdown-LaTeXExporter') ];
			package: #'Microdown-HTMLExporter-Tests'
				with: [ spec requires: #( #'Microdown-HTMLExporter' 'Microdown-Tests' 'XMLParserHTML') ];			
			
			package: #'Microdown-LaTeXExporter'
				with: [ spec requires: #( #Microdown ) ];				
			package: #'Microdown-LaTeXExporter-Tests'
				with: [ spec requires: #( #'Microdown-LaTeXExporter' #'Microdown-Tests') ];

			package: #'Microdown-BeamerExporter'
				with: [ spec requires: #( #'Microdown-LaTeXExporter' ) ];				
			package: #'Microdown-BeamerExporter-Tests'
				with: [ spec requires: #( #'Microdown-LaTeXExporter-Tests') ];

			package: #'Microdown-PrettyPrinter'
				with: [ spec requires: #( #Microdown ) ];
			

			package: #'Microdown-PrettyPrinter-Tests'
				with: [ spec requires: #( #'Microdown-PrettyPrinter' #'Microdown-Tests') ].
				
			package: #'Microdown-Blog' with: [
				spec requires: #( #'Microdown' #'Mustache') ];
			package: #'Microdown-Blog-Tests' with: [
				spec requires: #( #'Microdown-Blog' ) ];
		
		"I do not want group without tests for now"
		spec
			group: 'Core' with: #('Microdown');
			group: 'Tests' with: #('Core' 'Microdown-Tests');
			group: 'RichText' with: #('Core' 'Microdown-RichTextComposer' );
			group: 'Extensions' with: #(
				"
				#'Microdown-RichTextPresenter'
				#'Microdown-RichTextPresenter-Tests'
				#'Microdown-DocumentBrowser'
				#'Microdown-DocumentBrowser-Tests'
				"
				#'Microdown-Evaluator'
				#'Microdown-Evaluator-Tests'
				#'Microdown-PrettyPrinter'
				#'Microdown-PrettyPrinter-Tests'
				#'Microdown-HTMLExporter'
				#'Microdown-HTMLExporter-Tests'				
				#'Microdown-LaTeXExporter'
				#'Microdown-LaTeXExporter-Tests'
				#'Microdown-Transformer'
				#'Microdown-Transformer-Tests');
			group: 'All' with: #('Core' 'Tests' 'Extensions' 'Microdown-Pharo-Tools' 'RichText') ]
]

{ #category : 'baselines' }
BaselineOfMicrodown >> mustache: spec [

	spec baseline: 'Mustache' with: [
		spec
			repository: 'github://noha/mustache:v1.0/repository';
			loads: #( 'Core' 'Tests' ) ]
]

{ #category : 'baselines' }
BaselineOfMicrodown >> postload: loader package: packageSpec [

	| p |
	self class name, ' postload ' traceCr. 

	p := (IceRepository repositoryNamed: 'microdown').
	p ifNil: [ p :=  (IceRepository repositoryNamed: 'Microdown') ].
	[ 
	(p ifNotNil: [ :p2 | (p2 packageNamed: 'BaselineOfMicrodown') reload ]) 
	] 
		on: MCMergeOrLoadWarning 
		do: [ :ex | ex load ]



]

{ #category : 'baselines' }
BaselineOfMicrodown >> preload: loader package: packageSpec [
	"Ignore pre and post loads if already executed"

	" the prelosing GH script cannot work because 
	it will remove the baseline and repository itself :)
	#( 'Microdown' ) do: [ :name |
		(IceRepository repositoryNamed: name)
			ifNil: [ self inform: 'Project not found: ' , name ]
			ifNotNil: [ :found |
				found
					unload;
					forget ] ]"
			
	| packagesToUnload |
	self class name, ' preload ' traceCr. 
	packagesToUnload := ((PackageOrganizer default packages 
		select: [ :each | each name beginsWith: 'Microdown' ])  collect: [ :each | each name ]) 
		reject: [ :each |  
 #('Microdown-RichTextPresenter' 'Microdown-RichTextPresenter-Tests') includes: each ].
	"these two are not managed by the microdown repo but the documentation.
	I should rename them in the future to avoid confusion"

	packagesToUnload do: 
		[ :each | 
			((IceRepository repositoryNamed: 'Microdown') packageNamed: each) unload ].


]

{ #category : 'external projects' }
BaselineOfMicrodown >> xmlParserHtml: spec [

	spec
		baseline: 'XMLParserHTML'
		with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/XML-XMLParserHTML/src' ]
]
