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
	
	spec for: #'common' do: [
		self pillar: spec.
		spec 
			package: #'Microdown';
			package: #'Microdown-Tests'  with: [
				spec requires:  #( #'Microdown') ];
			
			package: #'Microdown-Pillar' with: [
				spec requires:  #( #'Microdown' 'PillarModel') ];
			package: #'Microdown-Pillar-Tests' with: [
				spec requires:  #(#'Microdown-Pillar' #'Microdown-Tests') ];
			package: #'Microdown-Calypso' with: [
				spec requires:  #(#'Microdown-Pillar' 'Microdown-RichTextComposer') ];
			package: #'Microdown-RichTextComposer' with: [
				spec requires:  #('Microdown' #'Microdown-Pillar' 'PillarRichTextComposer' ) ]
			]

]

{ #category : #baselines }
BaselineOfMicrodown >> pillar: spec [
	spec baseline: 'Pillar' with: [ 
		spec repository: 'github://pillar-markup/pillar:dev-8/src' ].
	
	spec project: 'PillarModel' copyFrom: 'Pillar' with: [ 
			spec loads: #('Pillar-Model') ].
	
	spec project: 'PillarRichTextComposer' copyFrom: 'Pillar' with: [ 
			spec loads: #('rich text exporter') ].
]
