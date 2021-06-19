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
			package: #'Microdown-Pharo-Tools'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-PrettyPrinter'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-PrettyPrinter-Tests'
				with: [ spec requires: #( #'Microdown-PrettyPrinter' #'Microdown-Tests') ];
			package: #'Microdown-Pillar'
				with: [ spec requires: #( #Microdown #PillarDocumentModel ) ];
			package: #'Microdown-Pillar-Tests'
				with: [ spec requires: #( #'Microdown-Pillar' #'Microdown-Tests' ) ].
		spec
			group: 'Microdown' with: #('Microdown' #'Microdown-PrettyPrinter');
			group: 'Microdown-Pillar' with: #('Microdown' #'Microdown-Pillar' #'Microdown-Pillar-Tests');
			group: 'Tests' with: #('Microdown-Tests' #'Microdown-PrettyPrinter-Tests');
			group: 'All' with: #('Microdown' 'Tests' #'Microdown-Pharo-Tools') ]
]
